// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.src.metadata.type_metadata_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/src/metadata/type_metadata.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Create a bool type.
TypeMetadata _boolType() => new TypeMetadata('bool');
/// Create an integer type.
TypeMetadata _intType() => new TypeMetadata('int');
/// Create a double type.
TypeMetadata _doubleType() => new TypeMetadata('double');
/// Create a number type.
TypeMetadata _numType() => new TypeMetadata('num');
/// Create a string type.
TypeMetadata _stringType() => new TypeMetadata('String');
/// Create a List type.
TypeMetadata _listType(TypeMetadata type, [int depth = 0]) {
  var root = new TypeMetadata('List', arguments: [type]);

  return root;
}
/// Creates a user type.
TypeMetadata _userType() => new TypeMetadata('Foo');

/// Test entry point.
void main() {
  test('bool type', () {
    var type = _boolType();

    expect(type.isInt, false);
    expect(type.isDouble, false);
    expect(type.isNum, false);
    expect(type.isBool, true);
    expect(type.isString, false);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, true);
  });

  test('int type', () {
    var type = _intType();

    expect(type.isInt, true);
    expect(type.isDouble, false);
    expect(type.isNum, true);
    expect(type.isBool, false);
    expect(type.isString, false);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, true);
  });

  test('double type', () {
    var type = _doubleType();

    expect(type.isInt, false);
    expect(type.isDouble, true);
    expect(type.isNum, true);
    expect(type.isBool, false);
    expect(type.isString, false);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, true);
  });

  test('num type', () {
    var type = _numType();

    expect(type.isInt, false);
    expect(type.isDouble, false);
    expect(type.isNum, true);
    expect(type.isBool, false);
    expect(type.isString, false);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, true);
  });

  test('String type', () {
    var type = _stringType();

    expect(type.isInt, false);
    expect(type.isDouble, false);
    expect(type.isNum, false);
    expect(type.isBool, false);
    expect(type.isString, true);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, true);
  });

  test('User defined type', () {
    var type = _userType();

    expect(type.isInt, false);
    expect(type.isDouble, false);
    expect(type.isNum, false);
    expect(type.isBool, false);
    expect(type.isString, false);
    expect(type.isList, false);
    expect(type.isMap, false);
    expect(type.isBuiltin, false);
  });
}
