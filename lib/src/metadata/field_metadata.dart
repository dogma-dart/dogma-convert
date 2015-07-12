// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [FieldMetadata] class.
library dogma_data.src.metadata.field_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a library using Dogma Data for serialization.
class FieldMetadata extends Metadata {
  /// Whether the field should be decoded.
  final bool decode;
  /// Whether the field should be encoded.
  final bool encode;

  FieldMetadata(String name, this.decode, this.encode, {dynamic data})
      : super(name, data);
}
