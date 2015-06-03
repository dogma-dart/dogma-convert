# Dogma Data

> A serialization library for Dart.

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dogma-dart/dogma-data?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://drone.io/github.com/dogma-dart/dogma-data/status.png)](https://drone.io/github.com/dogma-dart/dogma-data/latest)
[![Coverage Status](https://coveralls.io/repos/dogma-dart/dogma-data/badge.svg?branch=master)](https://coveralls.io/r/dogma-dart/dogma-data?branch=master)

## Features
- Implicit (de)serialization of PODOs based on coding conventions.
- Explicit (de)serialization of PODOs using metadata annotations.
- Fully customizable (de)serialization behavior.
- Mirrors based implementation for fast iteration during development.
- Code generation to remove dependencies on mirrors.

## Installation
Currently the Dogma Data library is in a pre-release state and should be installed as a git dependency.

    # pubspec.yaml
    dependencies:
      dogma_data:
        git: git@github.com:dogma-dart/dogma-data.git

## Concepts
Dogma Data acts externally on Plain Old Dart Objects to perform the decoding and encoding. This is done through ModelDecoder and ModelEncoder instances. This separates the concerns of serialization from the model itself. A ModelDecoder or ModelEncoder cannot be instantiated directly, instead they are created through the ModelDecoders and ModelEncoders interface which provides instances of the decoders or encoders for a given library.

A simple example of obtaining a type's decoder and encoder follows. 

    // Import the mirrors implementation
    import 'package:dogma_data/mirrors.dart';
    // Implement the library containing the models
    import 'models.dart';
    
    void main() {
      // Signals that the mirrors implementation should be used
      useMirrors();
      
      // Get the ModelDecoders for the library.
      // This will get decoders for all models declared in the #models library
      var decoders = getDecoders(#models);
      
      // Get the ModelDecoder for the given type.
      // By convention this is the class name converted to camel-case
      // A cast is used to ensure that analysis occurs as the ModelDecoders class is a proxy object
      var decoder = decoders.person as ModelDecoder<Person>;
      
      // Convert the Map data into a Person object
      var person = decoder.convert({ 'name': 'Jane Doe' });
      
      // Model data can be reused by passing it into the convert method
      // This can be used to reduce the amount of garbage created when decoding models
      person = decoder.convert({ 'name': 'Joey Joe Joe Shabidu' }, person);
      
      // Get the ModelEncoders for the library
      // This follows the same guidelines as the deserialization path
      var encoders = getEncoders(#models);
      var encoder = encoders.person as ModelEncoder<Person>;
      var encoded = encoder.convert(person);
    }
    
## Model Requirements
Dogma Data places restrictions on the type of data it can encode and decode. This is to limit the problem space; keeping the complexity of the serialization logic in check.
- Models must be Plain Old Dart Objects.
  - They cannot contain an extends clause, which also disallows mixins, but they can contain an implements clause.
  - They must contain a default constructor.
- Any values that can be automatically serialized require defined types.
  - A variable can not be of type dynamic.
  - If the variable is a generic then the type parameter must be defined.
  - Use of final is not possible as only the default constructor will ever be called.

## Implicit (De)Serialization

For simple cases the serialization can be automatically generated from the model data. In this case any public member variables will be serialized into a map where the key is the variable name.

The following shows a library containing a model that can be serialized.

    // The symbol for the library is used to query for the decoder or encoder
    library models;
    
    // Import the common library to signal that the library contains model data
    import 'package:dogma_data/common.dart';
    
    class Person {
      String name = '';
      int age = 0;
    }

Map data that would be produced or consumed from the previous model looks like the following.

    {
      "name": "Jane Doe",
      "age": 21
    }

When developing a first party application it is likely that implicit serialization is all that is needed.

## Explicit (De)Serialization
Sometimes implicit serialization does not contain the required behavior from the decoder and/or encoder. This is somewhat likely to occur when accessing a third party API. To provide more control over the serialization process the Dogma Data library allows explicit serialization options.

### SerializationProperty
A SerializationProperty is an annotation which maps a key to the member variable. This is useful if the key within the map data does not correspond to the name within the model.

The following shows a model where the SerializationProperty is used.

    class Person {
      @SerializationProperty('full_name')
      String name;
      @SerializationProperty('current_age')
      int age;
    }
Map data that would be produced or consumed from the previous model looks like the following.

    {
      "full_name": "Jane Doe",
      "current_age": 21
    }
The SerializationProperty also has optional arguments which allow the decoding or encoding of a field to be turned off. By default they are turned on.

__IMPORTANT! If there is a SerializationProperty annotation present on a member variable then all member variables to serialize require annotations. This is true even if the name within the map is the same as the variable name. This is an all or nothing operation.__

### Custom ModelDecoder or ModelEncoder
When decoding or encoding requires working on multiple values within the map data or the model a custom ModelDecoder or ModelEncoder should be created. A model can have as many decoders and encoders as necessary. Dogma Data will combine the converters into a CompositeModelDecoder which will invoke the individual conversion routines one by one.

__IMPORTANT! This declaration needs to be present within the same library as the model in order for the linkage to be detected. Also the ordering within the CompositeModelDecoder is not guaranteed so do not rely on data from the respective converter to be present.__

## Features and bugs
Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dogma-dart/dogma-data/issues
