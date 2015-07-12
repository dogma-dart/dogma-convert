// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Metadata] class.
library dogma_data.src.metadata.metadata;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Base class for metadata involved in the serialization process.
class Metadata {
  /// The name associated with this metadata.
  final String name;
  /// The internal data used to populate the metadata.
  ///
  /// This field contains optional data that the implementation could choose to
  /// expose.
  final dynamic data;

  /// Creates an instance of the [Metadata] class with the given [name].
  Metadata(this.name, this.data);
}
