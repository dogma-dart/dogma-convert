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
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a field within a model.
///
/// The field metadata contains serialization information for generating
/// converters for the model holding the field.
class FieldMetadata extends Metadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The type information for the field.
  final TypeMetadata type;
  /// Whether the field should be decoded.
  final bool decode;
  /// Whether the field should be encoded.
  final bool encode;
  /// The serialization name.
  final String _serializationName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [FieldMetadata] with the given [name] and [type].
  ///
  /// Serialization is specified in the [decode] and [encode] fields. If the
  /// name to serialize to is different than the name of field then
  /// [serializationName] should be specified.
  FieldMetadata(String name, this.type, this.decode, this.encode, {String serializationName})
      : super(name)
      , _serializationName = serializationName ?? '';

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The name to use when serializing.
  ///
  /// If the serialization name was specified during construction that will be
  /// used; otherwise this will return the same value as [name].
  String get serializationName => _serializationName.isNotEmpty ? _serializationName : name;
}