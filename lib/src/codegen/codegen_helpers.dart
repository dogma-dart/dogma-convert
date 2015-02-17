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
        if (metadata.name.token.toString() == 'SerializationProperty') {
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
