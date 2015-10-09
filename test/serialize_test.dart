// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_convert.test.serialize;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_convert/serialize.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const String _fieldName = 'foo';
const String _decodeFunction = 'decodeFoo';
const String _encodeFunction = 'encodeFoo';

/// Test entry point.
void main() {
  test('field', () {
    var fieldName = 'foo';
    var serialize = new Serialize.field(_fieldName);

    expect(serialize.name, _fieldName);
    expect(serialize.decode, true);
    expect(serialize.encode, true);
    expect(serialize.decodeUsing, null);
    expect(serialize.encodeUsing, null);
    expect(serialize.mapping, null);
    expect(serialize.optional, false);
    expect(serialize.defaultsTo, null);
  });
  test('decodeField', () {
    var serialize = new Serialize.decodeField(_fieldName);

    expect(serialize.name, _fieldName);
    expect(serialize.decode, true);
    expect(serialize.encode, false);
    expect(serialize.decodeUsing, null);
    expect(serialize.encodeUsing, null);
    expect(serialize.mapping, null);
    expect(serialize.optional, false);
    expect(serialize.defaultsTo, null);
  });
  test('encodeField', () {
    var serialize = new Serialize.encodeField(_fieldName);

    expect(serialize.name, _fieldName);
    expect(serialize.decode, false);
    expect(serialize.encode, true);
    expect(serialize.decodeUsing, null);
    expect(serialize.encodeUsing, null);
    expect(serialize.mapping, null);
    expect(serialize.optional, false);
    expect(serialize.defaultsTo, null);
  });
  test('function', () {
    var serialize = new Serialize.function(
        _fieldName,
        decode: _decodeFunction,
        encode: _encodeFunction
    );

    expect(serialize.name, _fieldName);
    expect(serialize.decode, true);
    expect(serialize.encode, true);
    expect(serialize.decodeUsing, _decodeFunction);
    expect(serialize.encodeUsing, _encodeFunction);
    expect(serialize.mapping, null);
    expect(serialize.optional, false);
    expect(serialize.defaultsTo, null);

    var decodeSerialize = new Serialize.function(_fieldName, decode: _decodeFunction);

    expect(decodeSerialize.name, _fieldName);
    expect(decodeSerialize.decode, true);
    expect(decodeSerialize.encode, false);
    expect(decodeSerialize.decodeUsing, _decodeFunction);
    expect(decodeSerialize.encodeUsing, null);
    expect(decodeSerialize.mapping, null);
    expect(decodeSerialize.optional, false);
    expect(decodeSerialize.defaultsTo, null);

    var encodeSerialize = new Serialize.function(_fieldName, encode: _encodeFunction);

    expect(encodeSerialize.name, _fieldName);
    expect(encodeSerialize.decode, false);
    expect(encodeSerialize.encode, true);
    expect(encodeSerialize.decodeUsing, null);
    expect(encodeSerialize.encodeUsing, _encodeFunction);
    expect(encodeSerialize.mapping, null);
    expect(encodeSerialize.optional, false);
    expect(encodeSerialize.defaultsTo, null);
  });
  test('values', () {
    var values = {'a': 0, 'b': 2};
    var serialize = new Serialize.values(values);

    expect(serialize.name, null);
    expect(serialize.decode, true);
    expect(serialize.encode, true);
    expect(serialize.decodeUsing, null);
    expect(serialize.encodeUsing, null);
    expect(serialize.mapping, values);
    expect(serialize.optional, false);
    expect(serialize.defaultsTo, null);
  });
  test('using', () {
    var serialize = Serialize.using;

    expect(serialize.name, null);
    expect(serialize.decode, false);
    expect(serialize.encode, false);
    expect(serialize.decodeUsing, null);
    expect(serialize.encodeUsing, null);
    expect(serialize.mapping, null);
    expect(serialize.optional, true);
    expect(serialize.defaultsTo, null);
  });
}
