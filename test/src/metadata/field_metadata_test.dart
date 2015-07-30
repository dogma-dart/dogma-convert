// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.src.metadata.field_metadata_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/src/metadata/field_metadata.dart';
import 'package:dogma_data/src/metadata/type_metadata.dart';
import 'package:test/test.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The dummy type name.
const String _typeName = 'foo';
/// The dummy metadata name.
const String _metadataName = 'test';
/// The serialization name.
const String _serializationName = 'encode';

/// Checks the [metadata] values are equivalent to [name] and [serializationName].
void _checkValues(FieldMetadata metadata, String name, String serializationName) {
  expect(metadata.name, name);
  expect(metadata.serializationName, serializationName);
}

/// Test entry point.
void main() {
  test('Construction without explicit serialization', () {
    var type = new TypeMetadata(_typeName);
    var metadata = new FieldMetadata(_metadataName, type, true, true);

    _checkValues(metadata, _metadataName, _metadataName);
  });

  test('Construction with explicit serialization', () {
    var type = new TypeMetadata(_typeName);
    var metadata = new FieldMetadata(_metadataName, type, true, true, serializationName: _serializationName);

    _checkValues(metadata, _metadataName, _serializationName);
  });
}
