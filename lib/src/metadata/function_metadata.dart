// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [FunctionMetadata] class.
library dogma_data.src.metadata.function_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class FunctionMetadata extends Metadata {
  /// Whether function handles decoding.
  final bool decoder;

  FunctionMetadata(String name, this.decoder, {dynamic data})
      : super(name, data);
}
