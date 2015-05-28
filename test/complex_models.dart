// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.test.complex_models;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/data.dart';
import 'package:test/test.dart';

import 'models/customer_database.dart';

Map serializedComplexTestModel = {
    'customers': [
       {
         'name': 'Walter White',
         'address': {
           'address_line': '308 Negra Arroyo Lane',
           'city': 'Albuquerque',
           'state': 'NM',
           'zip_code': 87112
         },
         'phone_number': '555 555-1234'
       },
       {
         'name': 'Jessie Pinkman',
         'address': {
           'address_line': '9809 Margo Street',
           'city': 'Albuquerque',
           'state': 'NM',
           'zip_code': 87104
         },
         'phone_number': '555 555-2345'
       },
       {
         'name': 'Skylar White',
         'address': {
           'address_line': 'Eubank Avenue',
           'additional_address': '#60',
           'city': 'Albuquerque',
           'state': 'NM',
           'zip_code': 87112
         },
         'phone_number': '555 555-3456'
       },
       {
         'name': 'Lydia Rodarte-Quayle',
         'address': {
           'address_line': 'Somewhere',
           'city': 'Houston',
           'state': 'TX',
           'zip_code': 77002
         },
         'phone_number': '555 555-4567'
       }
    ]
};

CustomerDatabase createCustomerDatabase(Map serialized) {
  var database = new CustomerDatabase();
  var customers = serialized['customers'] as List;

  for (var customer in customers) {
    var customerModel = new Customer();

    customerModel.name = customer['name'];
    customerModel.phoneNumber = customer['phone_numnber'];

    var address = customer['address'] as Map;
    var addressModel = new Address();

    addressModel.address = address['address_line'];
    addressModel.city = address['city'];
    //addressModel.state = States.values[StatesCodec.nameValues.indexOf(address['state'])];
    addressModel.zipCode = address['zip_code'];

    if (address.containsKey('additional_address')) {
      addressModel.additionalAddress = address['additional_address'];
    }

    customerModel.address = addressModel;
    database.customers.add(customerModel);
  }

  return database;
}

void verifyCustomerDatabaseSerialization(CustomerDatabase model, Map serialized) {
  var serializedCustomers = serialized['customers'];
  var customers = model.customers;
  var count = customers.length;

  expect(count, serializedCustomers.length);

  for (var i = 0; i < count; ++i) {
    verifyCustomerSerialization(customers[i], serializedCustomers[i]);
  }
}

void verifyCustomerSerialization(Customer model, Map serialized) {
  expect(model.name, serialized['name']);
  expect(model.phoneNumber, serialized['phone_number']);

  verifyAddressModelSerialization(model.address, serialized['address']);
}

void verifyAddressModelSerialization(Address model, Map serialized) {
  expect(model.address, serialized['address_line']);
  expect(model.city, serialized['city']);
  expect(model.zipCode, serialized['zip_code']);

  var indexOf = States.values.indexOf(model.state);

  //expect(StatesCodec.nameValues[indexOf], serialized['state']);

  if (model.additionalAddress.isNotEmpty) {
    expect(model.additionalAddress, serialized['additional_address']);
  }
}

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void testDecode() {
  var serialized = serializedComplexTestModel;
  var decoder = getDecoders().customerDatabase;
  var decoded = decoder.convert(serialized);

  verifyCustomerDatabaseSerialization(decoded, serialized);
}

void testEncode() {
  var model = createCustomerDatabase(serializedComplexTestModel);

  var encoder = getEncoders().customerDatabase;
  var encoded = encoder.convert(model);

  verifyCustomerDatabaseSerialization(model, encoded);
}

void main() {
  test('decode', testDecode);
  test('encode', testEncode);
}
