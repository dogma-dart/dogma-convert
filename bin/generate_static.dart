// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.generate_static;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/src/codegen/library_generator.dart';

import 'utils.dart';

//---------------------------------------------------------------------
// Application entry point
//---------------------------------------------------------------------

// \TODO Currently just running sources manually

const _SOURCES = const {
  '/simple_test_model.dart': '''
library dogma.data.test.simple_test_model;
class SimpleTestModel {
  int testInt;
  double testDouble;
  num testNumInt;
  num testNumDouble;
  String testString;
  List<int> testIntList;
}
''',
  '/simple_test_model_annotated.dart': '''
library dogma.data.test.simple_test_model_annotated;
import 'package:dogma_data/common.dart';

class SimpleTestModelAnnotated {
  @SerializationProperty('test_int')
  int testInt;
  @SerializationProperty('test_double')
  double testDouble;
  @SerializationProperty('test_num_int')
  num testNumInt;
  @SerializationProperty('test_num_double')
  num testNumDouble;
  @SerializationProperty('test_string')
  String testString;
  @SerializationProperty('test_int_list', encode: true)
  List<int> testIntList;
}
'''
};


void main() {
  var context = initAnalyzer(_SOURCES);

  var buffer;
  var generator;

  // Write out the simple model
  buffer = new StringBuffer();

  generator = new LibraryGenerator(context.libraryFor('/simple_test_model.dart'));
  generator.write(buffer);

  print(buffer.toString());

  // Write out the simple annotated model
  buffer = new StringBuffer();

  generator = new LibraryGenerator(context.libraryFor('/simple_test_model_annotated.dart'));
  generator.write(buffer);

  print(buffer.toString());
}
