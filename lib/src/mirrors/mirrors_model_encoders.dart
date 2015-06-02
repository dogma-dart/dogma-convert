// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

/// An implementation of [ModelEncoders] using the [dart:mirrors] library.
class MirrorsModelEncoders extends _MirrorsModelConverters<MirrorsModelEncoder>
                           implements ModelEncoders
{
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for [MirrorModelEncoder].
  static ClassMirror _encoderMirror;
  /// The [ClassMirror] for [ModelEncoder].
  static ClassMirror _encoderInterfaceMirror;
  /// The [ClassMirror] for [CompositeModelEncoder].
  static ClassMirror _compositeEncoderMirror;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelEncoders] class.
  MirrorsModelEncoders._internal(List<LibraryMirror> searchLibraries)
      : super._internal(_encoderMirror, _encoderInterfaceMirror, _compositeEncoderMirror, searchLibraries);

  /// The [symbol] specified points to the root library to search for models
  /// in. If the [symbol] is null then the isolate's libraries are all loaded.
  ///
  /// This is a static method rather than a factory constructor as a factory
  /// constructor cannot be used as a function pointer.
  static MirrorsModelEncoders _createEncoder(Symbol symbol) {
    // Get the MirrorsModelEncoder from the library if necessary
    if (_encoderMirror == null) {
      var mirrorSystem = currentMirrorSystem();
      var library;

      // Get the mirror decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.mirrors'));
      _encoderMirror = library.declarations[new Symbol('MirrorsModelEncoder')];
      assert(_encoderMirror != null);

      // Get the decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.src.common.model_encoder'));
      _encoderInterfaceMirror = library.declarations[new Symbol('ModelEncoder')];

      // Get the composite decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.src.common.composite_model_encoder'));
      _compositeEncoderMirror = library.declarations[new Symbol('CompositeModelEncoder')];
    }

    return new MirrorsModelEncoders._internal(_getSearchLibraries(symbol));
  }

  //---------------------------------------------------------------------
  // ModelEncoders
  //---------------------------------------------------------------------

  ModelEncoder getEncoder(Symbol symbol) {
    return _getConverter(symbol);
  }
}
