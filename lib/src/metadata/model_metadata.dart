// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelMetadata] class.
library dogma_data.src.metadata.model_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';
import 'field_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

///
class ModelMetadata extends Metadata {
  final List<FieldMetadata> fields;
  ModelMetadata(String name, this.fields, {dynamic data})
      : super(name, data);
}
