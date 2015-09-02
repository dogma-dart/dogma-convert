// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [CompositeModelDecoder] class.
library dogma_data.src.composite_model_decoder;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'model_decoder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The [CompositeModelDecoder] combines a group of [ModelDecoder]s into a single [ModelDecoder].
///
/// A [CompositeModelDecoder] invokes the individual [ModelDecoder]s on a
/// single data input. It is used when multiple [ModelDecoder]s are required to
/// serialize the data into a single model instance.
class CompositeModelDecoder<Model> extends Converter<Map, Model> implements ModelDecoder<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ModelDecoder]s to combine.
  final List<ModelDecoder<Model>> decoders;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [CompositeModelDecoder] class with the given [decoders].
  CompositeModelDecoder(this.decoders);

  //---------------------------------------------------------------------
  // ModelDecoder
  //---------------------------------------------------------------------

  @override
  Model create() => decoders[0].create();

  @override
  Model convert(Map input, [Model model]) {
    if (model == null) {
      model = create();
    }

    for (var decoder in decoders) {
      model = decoder.convert(input, model);
    }

    return model;
  }
}
