// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains functions for getting information from the analyzer.
library dogma_data.src.codegen.codegen_helpers;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/element.dart';

//---------------------------------------------------------------------
// Constants
//---------------------------------------------------------------------

/// String representation of [SerializationFieldDecoder].
const String _serializationFieldDecoderName = 'SerializationFieldDecoder';
/// String representation of [SerializationProperty].
const String _serializationPropertyName = 'SerializationProperty';


/// Determines if the [annotation] corresponds to a [SerializationProperty].
bool _isSerializationPropertyAnnotation(ElementAnnotation annotation) {
  var element = annotation.element;

  return (element is ConstructorElement)
      ? element.returnType.name == _serializationPropertyName
      : false;
}

/// Determines if the given [element] contains any annotations for serialization.
///
/// Looks for the following metadata types.
///
/// * SerializationProperty
bool hasSerializationAnnotations(ClassElement element) {
  for (var field in element.fields) {
    for (var metadata in field.metadata) {
      if (_isSerializationPropertyAnnotation(metadata)) {
        return true;
      }
    }
  }

  return false;
}

/// Matches the [element] with its corresponding declaration within the compilation [unit].
ClassDeclaration findDeclaration(ClassElement element, CompilationUnit unit) {
  var name = element.name;

  var find = (declaration) {
    return (declaration is ClassDeclaration)
        ? declaration.name.name == name
        : false;
  };

  return unit.declarations.firstWhere(find, orElse: () => null);
}

/// Searches for an instance of the [symbol] within the library [element].
dynamic findSymbol(LibraryElement element, SymbolLiteral symbol) {
  var symbolComponents = symbol.components;
  var componentLength = symbolComponents.length;

  // Determine where to look based on the length of the symbol
  if (componentLength == 1) {
    var functionName = symbolComponents[0].toString();

    // Search for a function
    for (var unit in element.units) {
      for (var function in unit.functions) {
        if (function.name == functionName) {
          return function;
        }
      }
    }
  } else if (componentLength == 2) {
    var className = symbolComponents[0].toString();
    var methodName = symbolComponents[1].toString();

    // Search for a method
    for (var unit in element.units) {
      for (var declaration in unit.types) {
        if (declaration.name == className) {
          var classDeclaration = declaration as ClassElement;
          var method = classDeclaration.getMethod(methodName);

          if (method != null) {
            return method;
          }
        }
      }
    }
  }

  // \TODO Look in different libraries attached to the root

  // Could not find the Symbol
  return null;
}

/// Gets the serializable fields for the [element].
///
/// Iterates over every field in the class element and uses that to implictly
/// determine the serialization fields. This function should be used if there
/// are no annotations on the [element].
Map<String, ClassElement> getSerializableFields(ClassElement element) {
  var fields = {};

  for (var field in element.fields) {
    fields[field.name] = field;
  }

  return fields;
}

const String fieldString = 'field';
const String metadataString = 'metadata';
const String fieldSymbol = 'fieldSymbol';

Map<String, Map> getFieldMetadata(ClassElement element, ClassDeclaration declaration, String metadataClass) {
  var fields = {};

  for (var member in declaration.members) {
    if (member is FieldDeclaration) {
      // Get the name of the field.
      //
      // It appears that a member variable always has a variable list with a
      // single value. This can be used to get the name.
      var name = member.fields.variables[0].name.toString();

      // See if the metadata is referenced
      for (var metadata in member.metadata) {
        if (metadata.name.token.toString() == metadataClass) {
          fields[name] = {
              fieldString: member,
              metadataString: metadata
          };
        }
      }
    }
  }

  return fields;
}

Map<String, Map> getAnnotatedFields(ClassElement element, ClassDeclaration declaration, bool encode) {
  var metadataClass = encode ? 'SerializationFieldEncoder' : 'SerializationFieldDecoder';

  var fields = getFieldMetadata(element, declaration, metadataClass);

  fields.forEach((key, value) {
    var metadata = value[metadataString];
    var arguments = metadata.arguments.arguments;

    // First value is the symbol
    var symbol = arguments[0] as SymbolLiteral;

    // Find the element for the symbol
    var symbolElement = findSymbol(element.library, symbol);

    value[fieldSymbol] = symbolElement;

    if (symbolElement is FunctionElement) {
      print('Found function');
    } else if (symbolElement is MethodElement) {
      print('Found method');

      if (symbolElement.isStatic) {
        print('Found static member');
      } else {
        print('Found member function');
      }
    }
  });

  return fields;
}

/// Gets the serializable fields for the [element] given the associated [declaration].
///
/// The value of [encode] specifies whether the fields should be encodable.
/// This is specified through the [SerializationProperty] annotation. If false
/// then the decodable fields are returned.
///
/// It is assumed that the [declaration] is the same as [element]. The
/// declaration is needed to determine what the values of the
/// [SerializationProperty] are as this can not be queried through the elements
/// given by the analyzer.
Map<String, FieldElement> getAnnotatedSerializableFields(ClassElement element, ClassDeclaration declaration, bool encode) {
  // Pass over the declaration getting the values for the SerializationProperty
  var computed = {};

  for (var member in declaration.members) {
    // Metadata should only be on a field.
    //
    // A field corresponds with a member variable. Any getters/setters are
    // MethodDeclarations and are not currently being handled.
    if (member is FieldDeclaration) {
      // Get the name of the field.
      //
      // It appears that a member variable always has a variable list with a
      // single value. This can be used to get the name.
      var name = member.fields.variables[0].name.toString();

      // See if the metadata is referenced
      for (var metadata in member.metadata) {
        var metadataToken = metadata.name.token.toString();

        if (metadataToken == 'SerializationProperty') {
          // Get the actual arguments being passed in
          var arguments = metadata.arguments.arguments;
          var argumentCount = arguments.length;

          // First value is always required
          var target = arguments[0].value;

          // Next values are named parameters
          var shouldEncode = true;
          var shouldDecode = true;

          for (var i = 1; i < argumentCount; ++i) {
            // Named parameters are of type NamedExpression
            var argument = arguments[i] as NamedExpression;

            // These are booleans so the value can be directly accessed
            var boolean = argument.expression.value;

            // Get the label to get a string that doesn't contain a :
            var label = argument.name.label.toString();

            if (label == 'encode') {
              shouldEncode = boolean;
            } else {
              shouldDecode = boolean;
            }
          }

          var add = (encode) ? shouldEncode : shouldDecode;

          if (add) {
            computed[name] = target;
          }
        } else if (metadataToken == 'SerializationFieldDecoder') {
          // Get the actual arguments being passed in
          var arguments = metadata.arguments.arguments;

          // First value is the symbol
          var symbol = arguments[0] as SymbolLiteral;

          // Find the element for the symbol
          var symbolElement = findSymbol(element.library, symbol);

          if (symbolElement is FunctionElement) {
            print('Found function');
          } else if (symbolElement is MethodElement) {
            print('Found method');

            if (symbolElement.isStatic) {
              print('Found static member');
            } else {
              print('Found member function');
            }
          }
        }
      }
    }
  }

  // Determine what fields should be used
  var fields = {};

  // Associate the computed values with the actual fields
  for (var field in element.fields) {
    var value = computed[field.displayName];

    if (value != null) {
      fields[value] = field;
    }
  }

  return fields;
}

/// Determines whether the given [type] is a builtin type.
///
/// Types considered builtin.
///
/// * bool
/// * int
/// * double
/// * num
/// * String
bool isBuiltinType(DartType type) {
  var name = type.name;

  return
      (name == 'bool')   ||
      (name == 'double') ||
      (name == 'num')    ||
      (name == 'int')    ||
      (name == 'String');
}

/// Determines whether the given [type] is a [List].
///
/// Currently checks for [List] directly. This should be extended to use other
/// builtin List types.
bool isListType(DartType element) {
  return element.name == 'List';
}

bool isBuiltinListType() {
  return false;
}
