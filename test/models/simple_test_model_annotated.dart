// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.simple_test_model_annotated;

import 'package:dogma_data/common.dart';

/// A simple test model that is fully annotated.
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
