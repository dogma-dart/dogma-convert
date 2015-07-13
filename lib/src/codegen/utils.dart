// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.src.codegen.enum_converter_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/src/metadata/type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates a string representing the type [metadata].
String typeName(TypeMetadata metadata) {
  var buffer = new StringBuffer();
  var arguments = metadata.arguments;
  var argumentCount = arguments.length;
  buffer.write(metadata.name);

  if (argumentCount > 0) {
    buffer.write('<');

    buffer.write(typeName(arguments[0]));
    for (var i = 1; i < argumentCount; ++i) {
      buffer.write(',');
      buffer.write(typeName(arguments[i]));
    }

    buffer.write('>');
  }

  return buffer.toString();
}
