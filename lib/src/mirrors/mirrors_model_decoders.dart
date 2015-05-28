// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

/// An implementation of [ModelDecoders] using the [dart:mirrors] library.
class MirrorsModelDecoders extends _MirrorsConverters<MirrorsModelDecoder>
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
      : super._internal(_decoderClassMirror, searchLibraries);

  /// Factory method for creating a [MirrorsModelDecoders].
  ///
  /// The [symbol] specified points to the root library to search for models
  /// in. If the [symbol] is null then the isolate's libraries are all loaded.
  ///
  /// This is a static method rather than a factory constructor as a factory
  /// constructor cannot be used as a function pointer.
  static MirrorsModelDecoders _createDecoder(Symbol symbol) {
    // Get the MirrorsModelDecoder from the library if necessary
    if (_decoderClassMirror == null) {
      var dogmaMirrors = currentMirrorSystem().findLibrary(new Symbol('dogma_data.mirrors'));

      _decoderClassMirror = dogmaMirrors.declarations[new Symbol('MirrorsModelDecoder')];
    }

    return new MirrorsModelDecoders._internal(_getSearchLibraries(symbol));
  }

  //---------------------------------------------------------------------
  // ModelDecoders
  //---------------------------------------------------------------------

  ModelDecoder getDecoder(Symbol symbol) {
    return _getConverter(symbol);
  }
}
