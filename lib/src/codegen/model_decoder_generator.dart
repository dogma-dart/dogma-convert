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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ModelDecoderGenerator {
  final Map<String, FieldElement> serializableFields = new Map<String, FieldElement>();

  final Set<DartType> dependencies = new Set<DartType>();

  final ClassElement element;
  final ClassDeclaration declaration;

  ModelDecoderGenerator(this.element, this.declaration) {
    _populate();
  }

  void writeDecoder(StringBuffer buffer) {
    var modelType = element.displayName;

    // Write the class declaration
    buffer.writeln('class ${modelType}Decoder extends Converter<Map, $modelType> implements ModelDecoder<$modelType> {');

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
      }
    });

    buffer.writeln('\n    return model;');
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  void _writeBuiltinValue(StringBuffer buffer, String key, FieldElement field) {
    buffer.writeln('    model.${field.displayName} = input[\'$key\'];');
  }

  void _populate() {
    // Get the serializable fields
    var fields = (hasSerializationAnnotations(element))
        ? getAnnotatedSerializableFields(element, declaration, true)
        : getSerializableFields(element);

    serializableFields.addAll(fields);

    // Get the dependencies for the decoder
    serializableFields.forEach((key, value) {
      var check = value.type;

      if (isListType(check)) {
        check = check.typeArguments[0];
      }

      if (!isBuiltinType(check)) {
        dependencies.add(check);
      }
    });
  }
}
