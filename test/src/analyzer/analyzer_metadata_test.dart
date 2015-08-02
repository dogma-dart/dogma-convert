// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.src.analyzer.analyzer_metadata_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:cli_util/cli_util.dart';
import 'package:dogma_data/src/analyzer/analyzer_metadata.dart';
import 'package:dogma_data/src/analyzer/context.dart';
import 'package:dogma_data/src/metadata/function_metadata.dart';
import 'package:dogma_data/src/metadata/converter_metadata.dart';
import 'package:dogma_data/src/metadata/type_metadata.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  var context = analysisContext(path.current, getSdkDir().path);

  test('FunctionMetadata explicit', () {
    var metadata = libraryMetadata('test/libs/converter_functions_explicit.dart', context);

    expect(metadata.imported.isEmpty, true, reason: 'No imports');
    expect(metadata.exported.isEmpty, true, reason: 'No exports');
    expect(metadata.models.isEmpty, true, reason: 'No models in library');
    expect(metadata.converters.isEmpty, true, reason: 'No converters in library');
    expect(metadata.enumerations.isEmpty, true, reason: 'No enumerations in library');
    expect(metadata.functions.length, 2, reason: 'Two functions present');

    var decoder = metadata.functions.firstWhere((function) => function.name == 'decodeDuration');
    expect(decoder.decoder, true);
    expect(decoder.defaultConverter, true);

    var encoder = metadata.functions.firstWhere((function) => function.name == 'encodeDuration');
    expect(encoder.decoder, false);
    expect(encoder.defaultConverter, true);
  });
}
