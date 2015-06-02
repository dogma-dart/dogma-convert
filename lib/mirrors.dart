// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Implementation of the [dogma.data] services using mirrors.
library dogma_data.mirrors;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';
import 'dart:mirrors';

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:dogma_data/common.dart';

//---------------------------------------------------------------------
// dogma.data.common library
//---------------------------------------------------------------------

part 'src/mirrors/mirrors_helpers.dart';
part 'src/mirrors/mirrors_model_converters.dart';
part 'src/mirrors/mirrors_model_decoder.dart';
part 'src/mirrors/mirrors_model_decoders.dart';
part 'src/mirrors/mirrors_model_encoder.dart';
part 'src/mirrors/mirrors_model_encoders.dart';
part 'src/mirrors/symbol_helpers.dart';

void useMirrors() {
  configure(
      MirrorsModelDecoders._createDecoder,
      MirrorsModelEncoders._createEncoder
  );
}
