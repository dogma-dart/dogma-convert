// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

/// An implementation of [ModelDecoders] using the [dart:mirrors] library.
class MirrorsModelDecoders extends _MirrorsModelConverters<ModelDecoder>
                           implements ModelDecoders
{
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The [ClassMirror] for [MirrorsModelDecoder].
  static ClassMirror _decoderMirror;
  /// The [ClassMirror] for [ModelDecoder].
  static ClassMirror _decoderInterfaceMirror;
  /// The [ClassMirror] for [CompositeModelDecoder].
  static ClassMirror _compositeDecoderMirror;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [MirrorsModelDecoders] class.
  MirrorsModelDecoders._internal(List<LibraryMirror> searchLibraries)
      : super._internal(_decoderMirror, _decoderInterfaceMirror, _compositeDecoderMirror, searchLibraries);

  /// Factory method for creating a [MirrorsModelDecoders].
  ///
  /// The [symbol] specified points to the root library to search for models
  /// in. If the [symbol] is null then the isolate's libraries are all loaded.
  ///
  /// This is a static method rather than a factory constructor as a factory
  /// constructor cannot be used as a function pointer.
  static MirrorsModelDecoders _createDecoder(Symbol symbol) {
    // Get the decoder classes from the library if necessary
    if (_decoderMirror == null) {
      var mirrorSystem = currentMirrorSystem();
      var library;

      // Get the mirror decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.mirrors'));
      _decoderMirror = library.declarations[new Symbol('MirrorsModelDecoder')];
      assert(_decoderMirror != null);

      // Get the decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.src.common.model_decoder'));
      _decoderInterfaceMirror = library.declarations[new Symbol('ModelDecoder')];

      // Get the composite decoder implementation
      library = mirrorSystem.findLibrary(new Symbol('dogma_data.src.common.composite_model_decoder'));
      _compositeDecoderMirror = library.declarations[new Symbol('CompositeModelDecoder')];
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
