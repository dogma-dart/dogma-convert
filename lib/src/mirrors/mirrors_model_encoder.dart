// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [MirrorsModelEncoder] class.
library dogma.data.src.mirrors.mirrors_model_encoder;

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
import 'mirrors_model_encoders.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An implementation of [ModelEncoder] using reflection.
class MirrorsModelEncoder<Model> extends Converter<Model, Map> implements ModelEncoder<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for the [Model].
  final ClassMirror _classMirror;
  /// The serializable fields within the [Model].
  final Map<String, VariableMirror> _serializableFields;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelDecoder].
  factory MirrorsModelEncoder(MirrorsModelEncoders encoders, [ClassMirror classMirror]) {
    // \FIXME Remove classMirror argument and use the following code.
    // Blocked by - https://code.google.com/p/dart/issues/detail?id=20739
    // Get the class mirror
    //if (classMirror == null) {
    //  classMirror = reflectClass(Model);
    //}

    // Get the serialization fields
    var serializableFields = getSerializableVariableFields(classMirror, false);

    return new MirrorsModelEncoder._internal(classMirror, serializableFields);
  }

  /// Internal method to create an instance of the [MirrorsModelDecoder].
  ///
  /// Used to ensure that the mirror values are final.
  MirrorsModelEncoder._internal(this._classMirror, this._serializableFields);

  //---------------------------------------------------------------------
  // ModelEncoder
  //---------------------------------------------------------------------

  Map convert(Model input) {
    if (input == null) return {};

    var mapped = {};

    // Get the instance mirror
    var instanceMirror = reflect(input);

    _serializableFields.forEach((key, value) {
      mapped[key] = instanceMirror.getField(value.simpleName).reflectee;
    });

    // Match the fields
    return mapped;
  }
}
