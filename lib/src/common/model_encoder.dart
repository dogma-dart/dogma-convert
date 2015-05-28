// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.common;

/// Interface for encoding a [Model] from a [Map].
abstract class ModelEncoder<Model> implements Converter<Model, Map> {}
