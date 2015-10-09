// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

/// Runs all the tests to handle code coverage generation.
library dogma_convert.test.all;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'serialize_test.dart' as serialize_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  group('Serialize tests', serialize_test.main);
}
