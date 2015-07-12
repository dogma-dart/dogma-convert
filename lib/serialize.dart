// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Serialize] annotation.
library dogma_data.src.model.serialize;

// \TODO Use union types

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata for specifying the behavior of the serialization process.
class Serialize {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final String name;
  final dynamic decode;
  final dynamic encode;
  final Map mapping;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Serialize] class.
  const Serialize._internal({this.name: '',
                             this.decode: false,
                             this.encode: false,
                             this.mapping});

  const Serialize.field(this.name, {this.encode: true, this.decode: true})
      : mapping = null;

  const Serialize.through(this.name, {this.encode, this.decode})
      : mapping = null;

  const Serialize.values(this.mapping)
      : name = ''
      , decode = null
      , encode = null;

  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  static const Serialize decodeThrough = const Serialize._internal(decode: true);
  static const Serialize encodeThrough = const Serialize._internal(encode: true);
}
