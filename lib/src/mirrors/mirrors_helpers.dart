// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

//---------------------------------------------------------------------
// ClassMirror helpers
//---------------------------------------------------------------------

/// Gets the class mirror associated with the given [symbol].
ClassMirror _getClassMirror(Symbol symbol, List<LibraryMirror> searchLibraries) {
  for (var library in searchLibraries) {
    for (var declaration in library.declarations.values) {
      if (declaration is ClassMirror) {
        if (declaration.simpleName == symbol) {
          return declaration;
        }
      }
    }
  }

  return null;
}

List<ClassMirror> getClassConvertersOfType(Symbol symbol, Symbol converter, List<LibraryMirror> searchLibraries) {
  var converters = [];

  for (var library in searchLibraries) {
    for (var declaration in library.declarations.values) {
      if (declaration is ClassMirror) {
        for (var superinterface in declaration.superinterfaces) {
          if ((superinterface.simpleName == converter) && (superinterface.typeArguments[0].simpleName == symbol)) {
            converters.add(declaration);

            break;
          }
        }
      }
    }
  }

  return converters;
}

//---------------------------------------------------------------------
// VariableMirror helpers
//---------------------------------------------------------------------

bool _isBuiltinType(TypeMirror mirror) {
  Symbol simpleName = mirror.simpleName;

  return
    (simpleName == #bool)   ||
    (simpleName == #int)    ||
    (simpleName == #double) ||
    (simpleName == #num)    ||
    (simpleName == #String);
}

bool isListType(TypeMirror mirror) {
  Symbol simpleName = mirror.simpleName;

  return simpleName == #List;
}

//---------------------------------------------------------------------
// LibraryMirror helpers
//---------------------------------------------------------------------

List<LibraryMirror> _getSearchLibraries(Symbol symbol) {
  var mirrorSystem = currentMirrorSystem();
  var searchLibraries = [];

  if (symbol == null) {
    // Search the libraries loaded into the mirrors system
    for (var library in mirrorSystem.libraries.values) {
      if (_shouldSearchLibrary(library)) {
        searchLibraries.add(library);
      }
    }
  } else {
    var rootLibrary = mirrorSystem.findLibrary(symbol);

    // Add the imported library
    searchLibraries.add(rootLibrary);

    // Search the dependencies of the given library
    for (var dependency in rootLibrary.libraryDependencies) {
      var library = dependency.targetLibrary;

      if (_shouldSearchLibrary(library)) {
        searchLibraries.add(library);
      }
    }
  }

  return searchLibraries;
}

bool _shouldSearchLibrary(LibraryMirror mirror) {
  var uri = mirror.uri;

  // Ignore the dart core libraries and the dogma_dart library explicitly
  if ((uri.scheme != 'dart') && (!uri.path.startsWith('dogma_data'))) {
    return true;
  }

  return false;
}

//---------------------------------------------------------------------
// VariableMirror helpers
//---------------------------------------------------------------------

/// Gets the member variable declarations by querying the [classMirror].
Iterable<DeclarationMirror> _getMemberVariables(ClassMirror classMirror) {
  return classMirror.declarations.values.where((m) => m is VariableMirror && !m.isStatic);
}

Map<String, VariableMirror> _getSerializableVariableFields(ClassMirror classMirror, bool encode) {
  var memberVariables = _getMemberVariables(classMirror);

  // Determine if there are serialization annotations
  var isAnnotated = _hasSerializationAnnotations(memberVariables);

  if (isAnnotated) {
    return _getAnnotatedSerializableFields(memberVariables, encode);
  } else {
    return _getSerializableFields(memberVariables);
  }
}

/// Determines if any of the member [variables] contain serialization annotations.
bool _hasSerializationAnnotations(Iterable<DeclarationMirror> variables) {
  // Iterate through the declarations looking for the annotations
  for (var variable in variables) {
    for (var metadata in variable.metadata) {
      if (metadata.reflectee is SerializationProperty) {
        return true;
      }
    }
  }

  // Annotation not found
  return false;
}


Map<String, VariableMirror> _getAnnotatedSerializableFields(Iterable<DeclarationMirror> variables, bool encode) {
  var values = new Map<String, VariableMirror>();

  // Iterate through the declarations looking for the annotations
  for (var variable in variables) {
    for (var metadata in variable.metadata) {
      var reflectee = metadata.reflectee;

      if (reflectee is SerializationProperty) {
        var use = (encode) ? reflectee.encode : reflectee.decode;

        if (use) {
          values[reflectee.name] = variable;
        }
      }
    }
  }

  return values;
}

Map<String, VariableMirror> _getSerializableFields(Iterable<DeclarationMirror> variables) {
  var values = new Map<String, VariableMirror>();

  // Add all variables to the map
  for (var variable in variables) {
    var parsedSymbol = _parseSymbol(variable.simpleName);

    values[parsedSymbol] = variable;
  }

  return values;
}
