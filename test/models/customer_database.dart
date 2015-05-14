// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.test.models.customer_database;

import 'package:dogma_data/common.dart';

class Address {
  @SerializationProperty('address_line')
  String address;
  @SerializationProperty('additional_address')
  String additionalAddress = '';
  @SerializationProperty('city')
  String city;
  @SerializationProperty('state')
  States state;
  @SerializationProperty('zip_code')
  int zipCode;
}

class Customer {
  @SerializationProperty('name')
  String name;
  @SerializationProperty('address')
  Address address;
  @SerializationProperty('phone_number')
  String phoneNumber;
}

class CustomerDatabase {
  List<Customer> customers = [];
}

enum States {
  Texas,
  NewMexico
}
