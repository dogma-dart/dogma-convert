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

import 'model_decoder.dart';
import 'model_encoder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Decodes and encodes model data.
class ModelCodec<Model> extends Codec<Model, Map> {
  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a [ModelCodec] with the given [decoder] and [encoder].
  const ModelCodec({this.decoder, this.encoder});

  //---------------------------------------------------------------------
  // Codec
  //---------------------------------------------------------------------

  /// The model decoder.
  @override
  final ModelDecoder<Model> decoder;
  /// The model encoder.
  @override
  final ModelEncoder<Model> encoder;

  /// Decodes the given [input] into a [Model].
  ///
  /// If the [model] field is not specified a new [Model] will be instantiated
  /// through the [create] method and that will be returned.
  ///
  /// **Warning!** When reusing a model it is not currently reset to an initial
  /// state. If one of the fields is not specified or if there are fields not
  /// serialized to that were set from their defaults then this may cause
  /// unexpected behavior.
  @override
  Model decode(Map input, [Model model]) => decoder.convert(input, model);
}
