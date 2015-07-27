// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.src.codegen.library_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dart_style/dart_style.dart';
import 'package:dogma_data/src/metadata/library_metadata.dart';

import 'enum_converter_generator.dart';
import 'model_converter_generator.dart';
import 'model_generator.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The code formatter.
///
/// Used to clean up the Dart code according to the style guide.
final _formatter = new DartFormatter();

/// Formats the generated code.
String _formatCode(StringBuffer buffer) => _formatter.format(buffer.toString());

String generateConverters(LibraryMetadata metadata) {
  var buffer = new StringBuffer();

  // Write the models
  for (var model in metadata.models) {
    buffer.writeln(generateModelDecoder(model));
    buffer.writeln(generateModelEncoder(model));
  }

  // Write the enumerations
  for (var enumeration in metadata.enumerations) {
    buffer.writeln(generateEnumConverter(enumeration));
  }

  return _formatCode(buffer);
}

String generateUnmodifiableModels(LibraryMetadata metadata) {
  var buffer = new StringBuffer();

  for (var model in metadata.models) {
    buffer.writeln(generateUnmodifiableModelView(model));
  }

  return _formatCode(buffer);
}

String generateModels(LibraryMetadata metadata) {
  var buffer = new StringBuffer();

  for (var model in metadata.models) {
    buffer.writeln(generateModel(model));
  }

  return _formatCode(buffer);
}
