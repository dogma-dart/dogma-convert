// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Implementation of the [dogma.data] services using statically generated code.
library dogma.data.static;

import 'package:dogma_data/common.dart';

/// The registerd [ModelDecoders].
final Map<Symbol, ModelDecoders> _decoders = new Map<Symbol, ModelDecoders>();
/// The registerd [ModelEncoders].
final Map<Symbol, ModelEncoders> _encoders = new Map<Symbol, ModelEncoders>();

/// Registers the [decoders] with the given [symbol].
///
/// This should only be called by generated libraries!
void registerDecoders(Symbol symbol, ModelDecoders decoders) {
  _decoders[symbol] = decoders;
}

/// Registers the [encoders] with the given [symbol].
///
/// This should only be called by generated libraries!
void registerEncoders(Symbol symbol, ModelEncoders encoders) {
  _encoders[symbol] = encoders;
}

ModelDecoders _getDecoder(Symbol symbol) => _decoders[symbol];

ModelEncoders _getEncoder(Symbol symbol) => _encoders[symbol];

void useStatic() {
  configure(_getDecoder, _getEncoder);
}
