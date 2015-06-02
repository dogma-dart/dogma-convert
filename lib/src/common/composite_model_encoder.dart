// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [CompositeModelEncoder] class.
library dogma_data.src.common.composite_model_encoder;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'model_encoder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The [CompositeModelEncoder] combines a group of [ModelEncoder]s into a single [ModelEncoder].
///
/// A [CompositeModelEncoder] invokes the individual [ModelEncoder]s on a
/// single data input. It is used when multiple [ModelEncoder]s are required to
/// deserialize a model into a map representation.
class CompositeModelEncoder<Model> extends Converter<Model, Map> implements ModelEncoder<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ModelEncoder]s to combine.
  final List<ModelEncoder<Model>> encoders;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [CompositeModelEncoder] class with the given [encoders].
  CompositeModelEncoder(this.encoders);

  //---------------------------------------------------------------------
  // ModelEncoder
  //---------------------------------------------------------------------

  @override
  Map convert(Model input) {
    var values = {};

    for (var encoder in encoders) {
      values.addAll(encoder.convert(input));
    }

    return values;
  }
}
