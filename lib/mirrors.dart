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
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/common.dart';

import 'src/mirrors/mirrors_model_decoders.dart';
import 'src/mirrors/mirrors_model_encoders.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void useMirrors() {
  configure(
      MirrorsModelDecoders.createDecoder,
      MirrorsModelEncoders.createEncoder
  );
}
