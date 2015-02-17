// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.test_mirrors;

import 'package:unittest/unittest.dart';
import 'package:dogma_data/mirrors.dart';

import 'simple_models.dart' as simple_models;

void main() {
  useMirrors();

  group('dogma.data.mirrors', simple_models.main);
}
