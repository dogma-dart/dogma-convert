// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma.data.mirrors;

class MirrorsModelDecoder<Model> extends Converter<Map, Model> implements ModelDecoder<Model> {
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
  factory MirrorsModelDecoder([ClassMirror classMirror]) {
    // \FIXME Remove classMirror argument and use the following code.
    // Blocked by - https://code.google.com/p/dart/issues/detail?id=20739
    // Get the class mirror
    //if (classMirror == null) {
    //  classMirror = reflectClass(Model);
    //}

    // Get the serialization fields
    var serializableFields = _getSerializableVariableFields(classMirror, false);

    return new MirrorsModelDecoder._internal(classMirror, serializableFields);
  }

  /// Internal method to create an instance of the [MirrorsModelDecoder].
  ///
  /// Used to ensure that the mirror values are final.
  MirrorsModelDecoder._internal(this._classMirror, this._serializableFields);

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

    // Match the fields
    input.forEach((key, value) {
      var mirror = _serializableFields[key];

      if (mirror != null) {
        // Going to just set it currently...
        instanceMirror.setField(mirror.simpleName, value);
      }
    });

    return model;
  }
}
