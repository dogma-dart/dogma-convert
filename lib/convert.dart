// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelDecoder] and [ModelEncoder] interfaces.
///
/// Both interfaces are based on [Converter] from the `dart:convert` library.
/// This is done to have a common interface with the standard libraries. For
/// the decoder the input is a [Map], while for the encoder the output is a
/// [Map]. The [ModelEncoder] implementation matches the implementation
/// completely while the [ModelDecoder] deviates.
///
/// The [ModelDecoder] provides a different signature to the convert method. It
/// takes an additional optional parameter which allows the passing in of an
/// already instantiated model. This allows for an object to be reused. If an
/// instantiated object is not passed in then the create method should be
/// called before the serialization process begins.
library dogma_convert.convert;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'src/model_decoder.dart';
import 'src/model_encoder.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/model_codec.dart';
export 'src/model_decoder.dart';
export 'src/model_encoder.dart';
