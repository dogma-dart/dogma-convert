// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelEncoderGenerator] class.
library dogma.data.codegen.model_encoder_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/element.dart';

import 'codegen_helpers.dart';
import 'model_converter_generator.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ModelEncoderGenerator extends ModelConverterGenerator {
  ModelEncoderGenerator(ClassElement element, ClassDeclaration declaration)
      : super(element, declaration);

  void write(StringBuffer buffer) {
    var modelType = element.displayName;

    // Write the class declaration
    buffer.writeln('class ${modelType}Encoder extends Converter<$modelType, Map> implements ModelEncoder<$modelType> {');

    // Write the convert function
    buffer.writeln('  Map convert($modelType model) {');
    buffer.writeln('    var output = {};\n');

    serializableFields.forEach((key, value) {
      var check = value.type;

      var isList = isListType(check);

      if (isList) {
        check = check.typeArguments[0];
      }

      var isBuiltin = isBuiltinType(check);

      if (isBuiltin) {
        _writeBuiltinValue(buffer, key, value);
      }
    });

    buffer.writeln('\n    return output;');
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  void _writeBuiltinValue(StringBuffer buffer, String key, FieldElement field) {
    buffer.writeln('    output[\'$key\'] = model.${field.displayName};');
  }
}
