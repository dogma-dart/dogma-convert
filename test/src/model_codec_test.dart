// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_convert/convert.dart';

class _Foo {
  int bar;
}

class _FooDecoder extends Converter<Map, _Foo> implements ModelDecoder<_Foo> {
  const _FooDecoder();

  @override
  _Foo create() => new _Foo();

  @override
  _Foo convert(Map input, [_Foo model]) {
    model ??= create();

    model.bar = input['bar'];

    return model;
  }
}

class _FooEncoder extends Converter<_Foo, Map> implements ModelEncoder<_Foo> {
  const _FooEncoder();

  @override
  Map convert(_Foo input) {
    var model = {};

    model['bar'] = input.bar;

    return model;
  }
}

const ModelCodec<_Foo> _fooCodec = const ModelCodec<_Foo>(
    encoder: const _FooEncoder(),
    decoder: const _FooDecoder()
);

/// Test entry point.
void main() {
  test('decode', () {
    var input = { 'bar': 2 };

    var model = _fooCodec.decode(input);
    expect(model.bar, equals(input['bar']));

    var encoded = _fooCodec.encode(model);

    expect(encoded, equals(input));

    var newInput = { 'bar': 4 };
    var reused = _fooCodec.decode(newInput, model);
    expect(identical(reused, model), isTrue);
    expect(reused.bar, newInput['bar']);
  });
  test('encode', () {
    var model = new _Foo()
        ..bar = 5;

    var encoded = _fooCodec.encode(model);
    expect(encoded['bar'], model.bar);
    expect(encoded, hasLength(1));
  });
}
