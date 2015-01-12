// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.simple_models;

import 'package:dogma_data/data.dart';
import 'package:unittest/unittest.dart';

//---------------------------------------------------------------------
// Simple test model
//---------------------------------------------------------------------

class SimpleTestModel {
  int testInt;
  double testDouble;
  num testNumInt;
  num testNumDouble;
  String testString;
  List<int> testIntList;
}

Map serializedSimpleTestModel = {
  'testInt': 42,
  'testDouble': 3.14159265359,
  'testNumInt': 84,
  'testNumDouble': 6.28318530718,
  'testString': 'Foobar',
  'testIntList': [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
};

void verifySimpleTestModelSerialization(SimpleTestModel model, Map serialized) {
  expect(model.testInt, serialized['testInt']);
  expect(model.testDouble, serialized['testDouble']);
  expect(model.testNumInt, serialized['testNumInt']);
  expect(model.testNumDouble, serialized['testNumDouble']);
  expect(model.testString, serialized['testString']);
  expect(model.testIntList, serialized['testIntList']);
}

//---------------------------------------------------------------------
// Annotated simple test model
//---------------------------------------------------------------------

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
  @SerializationProperty('test_int_list')
  List<int> testIntList;
}

Map serializedSimpleTestModelAnnotated = {
  'test_int': 42,
  'test_double': 3.14159265359,
  'test_num_int': 84,
  'test_num_double': 6.28318530718,
  'test_string': 'Foobar',
  'test_int_list': [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
};

void verifySimpleTestModelAnnotatedSerialization(SimpleTestModelAnnotated model, Map serialized) {
  expect(model.testInt, serialized['test_int']);
  expect(model.testDouble, serialized['test_double']);
  expect(model.testNumInt, serialized['test_num_int']);
  expect(model.testNumDouble, serialized['test_num_double']);
  expect(model.testString, serialized['test_string']);
  expect(model.testIntList, serialized['test_int_list']);
}

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void testDecode() {
  var serialized = serializedSimpleTestModel;
  var decoder = getDecoders().getDecoder(#SimpleTestModel);
  var decoded = decoder.convert(serialized);

  verifySimpleTestModelSerialization(decoded, serialized);
}

void testDecodeAnnotated() {
  var serialized = serializedSimpleTestModelAnnotated;
  var decoder = getDecoders().getDecoder(#SimpleTestModelAnnotated);
  var decoded = decoder.convert(serialized);

  verifySimpleTestModelAnnotatedSerialization(decoded, serialized);
}

void testEncode() {
  var serialized = serializedSimpleTestModel;
  var model = new SimpleTestModel();

  model
      ..testInt       = serialized['testInt']
      ..testDouble    = serialized['testDouble']
      ..testNumInt    = serialized['testNumInt']
      ..testNumDouble = serialized['testNumDouble']
      ..testString    = serialized['testString']
      ..testIntList   = serialized['testIntList'];

  var encoder = getEncoders().getEncoder(#SimpleTestModel);
  var encoded = encoder.convert(model);

  verifySimpleTestModelSerialization(model, encoded);
}

void testEncodeAnnotated() {
  var serialized = serializedSimpleTestModelAnnotated;
  var model = new SimpleTestModelAnnotated();

  model
      ..testInt       = serialized['test_int']
      ..testDouble    = serialized['test_double']
      ..testNumInt    = serialized['test_num_int']
      ..testNumDouble = serialized['test_num_double']
      ..testString    = serialized['test_string']
      ..testIntList   = serialized['test_int_list'];

  var encoder = getEncoders().getEncoder(#SimpleTestModelAnnotated);
  var encoded = encoder.convert(model);

  verifySimpleTestModelAnnotatedSerialization(model, encoded);
}

void main() {
  test('decode', testDecode);
  test('decode annotated', testDecodeAnnotated);
  test('encode', testEncode);
  test('encode annotated', testEncodeAnnotated);
}
