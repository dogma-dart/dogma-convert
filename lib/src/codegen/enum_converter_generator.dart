// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.src.codegen.enum_converter_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/src/metadata/enum_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class EnumConverterGenerator {
  final EnumMetadata metadata;

  EnumConverterGenerator(this.metadata);

  void write(StringBuffer buffer) {
    var enumName = metadata.name;
    var values = metadata.values;
    var valueCount = values.length;
    var encoded = metadata.encoded;
    var encodeType = encoded[0].runtimeType.toString();
    var isString = encoded[0] is String;

    // Write out the decoding map
    buffer.writeln('final Map<$encodeType, $enumName> _decoding = {');

    for (var i = 0; i < valueCount; ++i) {
      var encode = encoded[i];

      if (isString) {
        encode = '"$encode"';
      }

      buffer.writeln('$encode: ${enumName}.${values[i]},');
    }

    // Write out the decode function
    buffer.writeln('$enumName decode$enumName($encodeType value) {');
    buffer.writeln('var decoded = _decoding[value];');
    buffer.writeln('return (decoded != null) ? decoded : $enumName.values[0];');
    buffer.writeln('}');

    // Write out the encoding list
    buffer.writeln('final List<$encodeType> _encoding = [');

    for (var i = 0; i < valueCount; ++i) {
      var encode = encoded[i];

      if (isString) {
        encode = '"$encode"';
      }

      buffer.writeln('$encode,');
    }
    buffer.writeln('];');

    // Write out the encode function
    buffer.writeln('$encodeType encode$enumName($enumName value) {');
    buffer.writeln('return _encoded[value.index];');
    buffer.writeln('}');
  }
}
