// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Serialize] annotation.
library dogma_data.serialize;

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
  /// Whether the field encoding/decoding is optional.
  ///
  /// If the value is optional then code generated should check for these cases
  /// and assign a value.
  final bool optional;
  /// The value that should be defaulted to when a field is optional.
  final dynamic defaultsTo;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Serialize] class.
  const Serialize._internal({this.name: '',
                             this.decode: false,
                             this.encode: false,
                             this.optional: true,
                             this.mapping,
                             this.defaultsTo});

  /// Serializes a field with the [name].
  ///
  /// The [name] refers to the string value that is present in the map. This
  /// may or may not match the name of the field itself.
  ///
  /// Setting [encode] to false means that the field should be ignored when
  /// encoding. Setting [decode] to false means that the field should be
  /// ignored when decoding.
  const Serialize.field(this.name,
                       {this.encode: true,
                        this.decode: true,
                        this.optional: false,
                        this.defaultsTo})
      : mapping = null;

  /// Serializes a field with the [name] by using the [encode] and [decode]
  /// functions.
  const Serialize.function(this.name,
                          {this.encode,
                           this.decode,
                           this.optional: false,
                           this.defaultsTo})
      : mapping = null;

  /// Serializes an enumeration using the [mapping].
  ///
  /// The mapping value should be of the form Map<T, Enum> where T is either
  /// a String or an int, and Enum is the name of the enumeration. Each
  /// enumeration value must be represented in the map and must contain a
  /// single mapping.
  ///
  /// An example of serializing colors based on hex codes follows.
  ///
  ///     @Serialize.values(const {
  ///       0xff0000: Color.red,
  ///       0x00ff00: Color.green,
  ///       0x0000ff: Color.blue
  ///     })
  ///     enum Color {
  ///       red,
  ///       green,
  ///       blue
  ///     }
  ///
  /// This is currently verbose due to the inability to add metadata to
  /// individual enumeration values.
  ///
  /// When this [issue](https://github.com/dart-lang/sdk/issues/23441) is
  /// resolved this setup will be deprecated.
  const Serialize.values(this.mapping)
      : name = ''
      , decode = null
      , encode = null
      , optional = false
      , defaultsTo = null;

  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Marks a function as being the default decoder/encoder for a type.
  ///
  /// Whether the function is used for encoding or decoding is determined by
  /// the return type or the first parameter being a user defined type.
  static const Serialize using = const Serialize._internal();
}
