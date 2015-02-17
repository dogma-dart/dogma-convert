// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.test_static;

import 'package:unittest/unittest.dart';
import 'package:dogma_data/static.dart';

import 'generated/simple_test_model_static.dart' as simple_test_model_static;
import 'generated/simple_test_model_annotated_static.dart' as simple_test_model_annotated_static;

import 'simple_models.dart' as simple_models;

void main() {
  // Initialize the static library
  useStatic();

  // Register each of the generated decoders/encoders
  simple_test_model_static.register();
  simple_test_model_annotated_static.register();

  group('dogma.data.static', simple_models.main);
}
