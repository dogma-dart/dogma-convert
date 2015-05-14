// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.codegen.model_decoder_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/element.dart';

import 'codegen_helpers.dart';
import 'library_generator.dart';
import 'model_converter_generator.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ModelDecoderGenerator extends ModelConverterGenerator {
  ModelDecoderGenerator(ClassElement element, ClassDeclaration declaration)
      : super(element, declaration);

  void write(StringBuffer buffer) {
    var modelType = element.displayName;

    var className = modelType + 'Decoder';

    // Write the class declaration
    buffer.writeln('class $className extends Converter<Map, $modelType> implements ModelDecoder<$modelType> {');

    // Write a constructor and member variables if there are any dependencies
    if (dependencies.isNotEmpty) {
      var constructorList = '';
      var first = true;

      for (var dependency in dependencies) {
        if (!first) {
          constructorList += ', ';
        } else {
          first = false;
        }

        var dependencyName = LibraryGenerator.toVariableName(dependency.displayName) + 'Decoder';

        buffer.writeln('  ModelDecoder<${dependency.displayName}> $dependencyName;');

        constructorList += 'this.$dependencyName';
      }

      buffer.writeln('\n  $className($constructorList);\n');
    }

    // Write the create function
    buffer.writeln('  $modelType create() => new ${modelType}();\n');

    // Write the convert function
    buffer.writeln('  $modelType convert(Map input, [$modelType model = null]) {');
    buffer.writeln('    if (model == null) {');
    buffer.writeln('      model = create();');
    buffer.writeln('    }\n');

    serializableFields.forEach((key, value) {
      var check = value.type;

      var isList = isListType(check);

      if (isList) {
        check = check.typeArguments[0];
      }

      var isBuiltin = isBuiltinType(check);

      if (isBuiltin) {
        _writeBuiltinValue(buffer, key, value);
      } else {
        var fieldName = value.displayName;
        var decoder = LibraryGenerator.toVariableName(check.displayName) + 'Decoder';

        if (isList) {
          buffer.writeln('    {');
          buffer.writeln('      var $fieldName = model.$fieldName;');
          buffer.writeln('      $fieldName.clear();');
          buffer.writeln('      for (var iter in input[\'$key\']) {');
          buffer.writeln('        $fieldName.add($decoder.convert(iter));');
          buffer.writeln('      }');
          buffer.writeln('    }');
        } else {
          buffer.writeln('    model.$fieldName = $decoder.convert(input[\'$key\'], model.$fieldName);');
        }
      }
    });

    buffer.writeln('\n    return model;');
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  void _writeBuiltinValue(StringBuffer buffer, String key, FieldElement field) {
    buffer.writeln('    model.${field.displayName} = input[\'$key\'];');
  }
}
