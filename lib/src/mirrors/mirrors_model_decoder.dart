// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [MirrorsModelDecoder] class.
library dogma_data.src.mirrors.mirrors_model_decoder;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';
import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/common.dart';

import 'mirrors_helpers.dart';
import 'mirrors_model_decoders.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Decodes a [value] into an instance using a [mirror].
typedef void _DecodeFunction(InstanceMirror mirror, dynamic value);

/// An implementation of [ModelDecoder] using reflection.
class MirrorsModelDecoder<Model> extends Converter<Map, Model> implements ModelDecoder<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for the [Model].
  final ClassMirror _classMirror;

  final Map<String, _DecodeFunction> _fieldDecoders;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelDecoder].
  factory MirrorsModelDecoder(MirrorsModelDecoders decoders, ClassMirror classMirror) {
    // \FIXME Remove classMirror argument and use the following code.
    // Blocked by - https://code.google.com/p/dart/issues/detail?id=20739
    // Get the class mirror
    //if (classMirror == null) {
    //  classMirror = reflectClass(Model);
    //}

    // Get the serialization fields
    var serializableFields = getSerializableVariableFields(classMirror, false);
    var fieldDecoders = {};

    serializableFields.forEach((key, value) {
      var type = value.type;
      var isList = isListType(type);
      var isMap = isMapType(type);

      if (isList) {
        type = type.typeArguments[0];
      }

      if (isMap) {
        type = type.typeArguments[1];
      }

      var field = value.simpleName;
      var decoder;

      if (isBuiltinType(type)) {
        decoder = _builtinWrapper(field);
      } else {
        assert(type is ClassMirror);

        if (!type.isEnum) {
          var modelDecoder = decoders.getConverter(type.simpleName);

          decoder = (isList)
              ? _decoderListWrapper(field, modelDecoder)
              : _decoderWrapper(field, modelDecoder);
        } else {
          print('ENUMMMM');
        }
      }

      // \TODO REMOVE if
      if (decoder != null)
      fieldDecoders[key] = decoder;
    });

    return new MirrorsModelDecoder._internal(classMirror, fieldDecoders);
  }

  /// Internal method to create an instance of the [MirrorsModelDecoder].
  ///
  /// Used to ensure that the mirror values are final.
  MirrorsModelDecoder._internal(this._classMirror, this._fieldDecoders);

  //---------------------------------------------------------------------
  // ModelDecoder
  //---------------------------------------------------------------------

  Model create() {
    // Use the class mirror to create a new instance
    //
    // Using Symbol('') will result in the default constructor being called.
    // Its assumed that the default constructor does not take any arguments.
    return _classMirror.newInstance(new Symbol(''), []).reflectee;
  }

  Model convert(Map input, [Model model = null]) {
    if (model == null) {
      model = create();
    }

    // Get the instance mirror
    var instanceMirror = reflect(model);

    // Decode the fields with data present
    _fieldDecoders.forEach((field, decoder) {
      var value = input[field];

      if (value != null) {
        decoder(instanceMirror, value);
      }
    });

    return model;
  }

  static _DecodeFunction _builtinWrapper(Symbol field) {
    return (InstanceMirror instance, dynamic value) {
      instance.setField(field, value);
    };
  }

  static _DecodeFunction _decoderWrapper(Symbol field, ModelDecoder decoder) {
    return (InstanceMirror instance, dynamic value) {
      var current = instance.getField(field).reflectee;

      instance.setField(field, decoder.convert(value, current));
    };
  }

  static _DecodeFunction _decoderListWrapper(Symbol field, ModelDecoder decoder) {
    return (InstanceMirror instance, List values) {
      var converted = [];

      for (var value in values) {
        converted.add(decoder.convert(value));
      }

      instance.setField(field, converted);
    };
  }
}
