// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [SerializationFieldDecoder] annotation.
library dogma_data.src.common.serialization_field_decoder;

class SerializationFieldDecoder {
  final Symbol symbol;
  final String name;

  const SerializationFieldDecoder(this.symbol, [this.name = '']);
}

typedef Model FieldDecoder<Model>(dynamic input, Model model);
