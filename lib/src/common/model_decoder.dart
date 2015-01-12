// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma.data.common;

/// Interface for decoding a [Model] from a [Map].
abstract class ModelDecoder<Model> implements Converter<Map, Model> {
  /// Creates an instance of the [Model] class.
  Model create();

  Model convert(Map input, [Model model = null]);
}
