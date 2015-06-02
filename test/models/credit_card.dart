// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.models.credit_card;

import 'dart:convert';
import 'package:dogma_data/common.dart';

class CreditCard {
  @SerializationProperty('name')
  String name = '';
  @SerializationProperty('number')
  int number = 0;
  String issuer = '';
  bool isValid = false;
}

class CreditCardMetadataDecoder extends Converter<Map, CreditCard> implements ModelDecoder<CreditCard> {
  CreditCard create() => new CreditCard();

  CreditCard convert(Map input, [CreditCard model]) {
    if (model == null) {
      model = create();
    }

    var number = input['number'];

    model.issuer = _issuer(number);
    model.isValid = _isValid(number);

    return model;
  }

  static bool _isValid(int number) {
    var sum = 0;

    while (number != 0) {
      var twoDigits = number % 100;
      var firstValue = 2 * (twoDigits ~/ 10);

      if (firstValue >= 10) {
        firstValue = (firstValue ~/ 10) + (firstValue % 10);
      }

      var secondValue = twoDigits % 10;

      sum += firstValue + secondValue;

      number ~/= 100;
    }

    return sum % 10 == 0;
  }

  static String _issuer(int number) {
    var numberString = number.toString();

    // This is just a subset of data to illustrate having a custom decoder
    if (numberString[0] == '4') {
      return 'Visa';
    } else if (numberString == '51') {
      return 'MasterCard';
    } else {
      return 'Unknown';
    }
  }
}
