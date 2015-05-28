// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.common;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'src/common/model_decoders.dart';
import 'src/common/model_encoders.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/common/model_decoder.dart';
export 'src/common/model_decoders.dart';
export 'src/common/model_encoder.dart';
export 'src/common/model_encoders.dart';
export 'src/common/serialization_field_decoder.dart';
export 'src/common/serialization_property.dart';
export 'src/common/serialization_values.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Creates an instance of [ModelDecoders] given the [library] symbol.
typedef ModelDecoders ModelDecodersFactory(Symbol library);
/// Creates an instance of [ModelEncoders] given the [library] symbol.
typedef ModelEncoders ModelEncodersFactory(Symbol library);

/// The [ModelDecodersFactory] to use with [getDecoders].
ModelDecodersFactory _modelDecodersFactory;
/// The [ModelEncodersFactory] to use with [getEncoders].
ModelEncodersFactory _modelEncodersFactory;

/// Configures the [dogma_dart] library.
void configure(ModelDecodersFactory decodersFactory, ModelEncodersFactory encodersFactory) {
  _modelDecodersFactory = decodersFactory;
  _modelEncodersFactory = encodersFactory;
}

ModelDecoders getDecoders([Symbol library]) {
  return _modelDecodersFactory(library);
}

ModelEncoders getEncoders([Symbol library]) {
  return _modelEncodersFactory(library);
}
