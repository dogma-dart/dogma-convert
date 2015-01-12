// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma.data.common;

/// An interface to query a [ModelEncoder].
///
/// An instance of [ModelEncoders] cannot be created directly. Instead use the
/// [getEncoders] function to retrieve.
abstract class ModelEncoders {
  ModelEncoder getEncoder(Symbol symbol);
}
