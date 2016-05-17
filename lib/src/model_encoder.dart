// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Interface for encoding a [Model] from a [Map].
///
/// The [ModelEncoder] takes a [Model] as input and converts it from a Plain
/// Old Dart Object (PODO) to a [Map]. Its behavior is defined by an explicit
/// or implicit serialization on the [Model].
abstract class ModelEncoder<Model> implements Converter<Model, Map> {}
