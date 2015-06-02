// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelDecoder] interface.
library dogma_data.src.common.model_decoder;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Interface for decoding a [Model] from a [Map].
///
/// The [ModelDecoder] takes a [Map] as input and converts it into a Plain
/// Old Dart Object (PODO). Its behavior is defined by an explicit or implicit
/// serialization on the [Model].
abstract class ModelDecoder<Model> implements Converter<Map, Model> {
  /// Creates an instance of the [Model] class.
  Model create();

  /// Converts the given [input] into a [Model].
  ///
  /// If the [model] field is not specified a new [Model] will be instantiated
  /// through the [create] method and that will be returned.
  ///
  /// **Warning!** When reusing a model it is not currently reset to an initial
  /// state. If one of the fields is not specified or if there are fields not
  /// serialized to that were set from their defaults then this may cause
  /// unexpected behavior.
  Model convert(Map input, [Model model = null]);
}
