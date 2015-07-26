// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [EnumMetadata] class.
library dogma_data.src.metadata.enum_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a library using Dogma Data for serialization.
class EnumMetadata extends Metadata {
  /// The name of the individual enumerations.
  final List<String> values;
  /// The encoded values.
  final List<String> encoded;

  factory EnumMetadata(String name, List<String> values, {List<String> encoded, dynamic data}) {
    encoded ??= new List<String>.from(values);

    return new EnumMetadata._internal(name, values, encoded, data: data);
  }

  EnumMetadata._internal(String name, this.values, this.encoded, {dynamic data})
      : super(name, data);
}
