// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.test_suite;

import 'package:test/test.dart';

import 'simple_models.dart' as simple_models;
import 'complex_models.dart' as complex_models;
import 'custom_converter.dart' as custom_decoder;

void runTests() {
  group('dogma_data.simple_models', simple_models.main);
  group('dogma_data.complex_models', complex_models.main);
  group('dogma_data.custom_decoder', custom_decoder.main);
}
