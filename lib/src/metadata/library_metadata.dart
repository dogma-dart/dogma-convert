// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [LibraryMetadata] class.
library dogma_data.src.metadata.library_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'enum_metadata.dart';
import 'metadata.dart';
import 'model_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a library using Dogma Data for serialization.
class LibraryMetadata extends Metadata {
  final List<LibraryMetadata> imported;
  final List<LibraryMetadata> exported;

  final List<ModelMetadata> models;
  final List<EnumMetadata> enumerations;

  LibraryMetadata(String name,
                 {dynamic data,
                  this.imported,
                  this.exported,
                  this.models,
                  this.enumerations})
      : super(name, data);
}
