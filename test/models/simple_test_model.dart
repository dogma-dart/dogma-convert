// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.simple_test_model;

/// A simple test model with no annotations.
///
/// Having no annotations means that all the fields on the model are
/// serializable and can be both encoded and decoded.
class SimpleTestModel {
  int testInt;
  double testDouble;
  num testNumInt;
  num testNumDouble;
  String testString;
  List<int> testIntList;
}
