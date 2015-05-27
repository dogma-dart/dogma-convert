// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [MirrorsModelDecoders] class.
library dogma.data.src.mirrors.mirrors_model_decoders;

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
import 'mirrors_model_decoder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An implementation of [ModelDecoders] using the [dart:mirrors] library.
class MirrorsModelDecoders extends MirrorsConverters<MirrorsModelDecoder>
                           implements ModelDecoders
{
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for [MirrorModelDecoder].
  static ClassMirror _decoderClassMirror;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelDecoders] class.
  MirrorsModelDecoders._internal(List<LibraryMirror> searchLibraries)
      : super(_decoderClassMirror, searchLibraries);

  /// Factory method for creating a [MirrorsModelDecoders].
  ///
  /// The [symbol] specified points to the root library to search for models
  /// in. If the [symbol] is null then the isolate's libraries are all loaded.
  ///
  /// This is a static method rather than a factory constructor as a factory
  /// constructor cannot be used as a function pointer.
  static MirrorsModelDecoders createDecoder(Symbol symbol) {
    // Get the MirrorsModelDecoder from the library if necessary
    if (_decoderClassMirror == null) {
      var dogmaMirrors = currentMirrorSystem().findLibrary(new Symbol('dogma.data.src.mirrors.mirrors_model_decoder'));

      _decoderClassMirror = dogmaMirrors.declarations[new Symbol('MirrorsModelDecoder')];
    }

    return new MirrorsModelDecoders._internal(getSearchLibraries(symbol));
  }

  //---------------------------------------------------------------------
  // ModelDecoders
  //---------------------------------------------------------------------

  ModelDecoder getDecoder(Symbol symbol) {
    return getConverter(symbol);
  }
}
