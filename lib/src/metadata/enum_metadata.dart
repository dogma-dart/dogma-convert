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

/// Contains metadata for an enumeration.
///
/// The enumeration metadata contains the names of the [values] as well as an
/// [encoded] variant for serialization.
class EnumMetadata extends Metadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The name of the individual enumerations.
  final List<String> values;
  /// The encoded values.
  final List<String> encoded;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [EnumMetadata] with the given [name] and [values].
  ///
  /// If there is a specific encoding for the values then [encoded] should be
  /// provided, otherwise the individual [values] will be used as the
  /// serialized names.
  factory EnumMetadata(String name, List<String> values, {List<String> encoded}) {
    encoded ??= new List<String>.from(values);

    return new EnumMetadata._internal(name, values, encoded);
  }

  /// Creates an instance of [EnumMetadata].
  EnumMetadata._internal(String name, this.values, this.encoded)
      : super(name);
}