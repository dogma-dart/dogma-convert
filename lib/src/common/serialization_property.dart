// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.common;

/// Metadata for specifying the mapping between a variable and [Map] data.
///
/// The [SerializationProperty] specifies how a member variable should be
/// serialized to and from a [Map]. The serialization doesn't have to be two
/// way. A value can be ignored when encoding or when decoding.
///
///     class TestModel {
///       @SerializationProperty('foo')
///       String foo;
///       @SerializationProperty('bar_no_encode', encode: false)
///       int barDontEncode;
///       @SerializationProperty('bar_no_decode', decode: false)
///       int barDontDecode;
///     }
class SerializationProperty {
  /// The name within the [Map] for the property.
  final String name;
  /// Whether the property should be encoded.
  final bool encode;
  /// Whether the property should be decoded.
  final bool decode;

  /// Creates an instance of the [SerializationProperty] class.
  ///
  /// The [name] specified refers to the string value within the [Map] that
  /// corresponds to the member variable the property refers to. Additionally
  /// the member variable can be ignored when encoding or decoding through the
  /// value of [encode] and [decode] respectively.
  const SerializationProperty(this.name, {this.encode: true, this.decode: true});
}
