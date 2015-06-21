// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.bin.generate_static;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'dart:io';
import 'package:dogma_data/src/codegen/library_generator.dart';

import 'utils.dart';

//---------------------------------------------------------------------
// Application entry point
//---------------------------------------------------------------------

// Test files
List<String> testFiles = [
  "../test/models/credit_card.dart",
  "../test/models/customer_database.dart",
  "../test/models/simple_test_model.dart",
  "../test/models/simple_test_model_annotated.dart"
];

void main() {
  var sourceMap = new Map<String, String>();
  var buffer = new StringBuffer();
  var generator;

  // Read in all test model files
  for(var file in testFiles) {
    sourceMap[file] = new File(file).readAsStringSync();
  }

  // Init analyzer with test model files
  var context = initAnalyzer(sourceMap);

  // Generate static encoders/decoders
  for(var file in testFiles) {
    generator = new LibraryGenerator(context.libraryFor(file));
    generator.write(buffer);
  }

  // Print all generated output
  print(buffer.toString());
}

