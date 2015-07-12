// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ConverterMetadata] class.
library dogma_data.src.metadata.converter_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ConverterMetadata extends Metadata {
  /// Whether the converter handles decoding.
  final bool decoder;
  ConverterMetadata(String name, this.decoder, {dynamic data})
      : super(name, data);

  bool get encoder => !decoder;
}
