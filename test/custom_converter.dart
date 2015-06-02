// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.custom_decoder;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/data.dart';
import 'package:test/test.dart';

import 'models/credit_card.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const _creditCardLibrary = #dogma_data.test.models.credit_card;

Map serializedCreditCard = {
  'name': 'John Doe',
  'number': 4417123456789113
};

void testDecode() {
  var serialized = serializedCreditCard;
  var decoder = getDecoders(_creditCardLibrary).creditCard as ModelDecoder<CreditCard>;
  var decoded = decoder.convert(serialized);

  expect(decoded.name, serialized['name']);
  expect(decoded.number, serialized['number']);
  expect(decoded.isValid, true);
  expect(decoded.issuer, 'Visa');
}

void main() {
  test('decode', testDecode);
}
