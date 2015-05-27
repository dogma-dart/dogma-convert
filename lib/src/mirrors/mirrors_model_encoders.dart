// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [MirrorsModelEncoders] class.
library dogma.data.src.mirrors.mirrors_model_encoders;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_data/common.dart';

import 'mirrors_converters.dart';
import 'mirrors_helpers.dart';
import 'mirrors_model_encoder.dart';

/// An implementation of [ModelEncoders] using the [dart:mirrors] library.
class MirrorsModelEncoders extends MirrorsConverters<MirrorsModelEncoder>
                           implements ModelEncoders
{
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for [MirrorModelEncoder].
  static ClassMirror _encoderClassMirror;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelEncoders] class.
  MirrorsModelEncoders._internal(List<LibraryMirror> searchLibraries)
      : super(_encoderClassMirror, searchLibraries);

  /// The [symbol] specified points to the root library to search for models
  /// in. If the [symbol] is null then the isolate's libraries are all loaded.
  ///
  /// This is a static method rather than a factory constructor as a factory
  /// constructor cannot be used as a function pointer.
  static MirrorsModelEncoders createEncoder(Symbol symbol) {
    // Get the MirrorsModelEncoder from the library if necessary
    if (_encoderClassMirror == null) {
      var dogmaMirrors = currentMirrorSystem().findLibrary(new Symbol('dogma.data.src.mirrors.mirrors_model_encoder'));

      _encoderClassMirror = dogmaMirrors.declarations[new Symbol('MirrorsModelEncoder')];
    }

    return new MirrorsModelEncoders._internal(getSearchLibraries(symbol));
  }

  //---------------------------------------------------------------------
  // ModelEncoders
  //---------------------------------------------------------------------

  ModelEncoder getEncoder(Symbol symbol) {
    return _getConverter(symbol);
  }
}
