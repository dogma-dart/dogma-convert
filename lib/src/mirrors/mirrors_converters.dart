// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

abstract class _MirrorsConverters<Converter> {
  final ClassMirror _converterClassMirror;
  final Map<Symbol, Converter> _converters = new Map<Symbol, Converter>();
  final List<LibraryMirror> _searchLibraries;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  _MirrorsConverters._internal(this._converterClassMirror, this._searchLibraries);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      var classSymbol = _symbolToUppercase(invocation.memberName);
      var decoder = _getConverter(new Symbol(classSymbol));

      if (decoder != null) {
        return decoder;
      }
    }

    throw new NoSuchMethodError(
        this,
        invocation.memberName,
        invocation.positionalArguments,
        invocation.namedArguments
    );
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  Converter _getConverter(Symbol symbol) {
    var converter = _converters[symbol];

    if (converter == null) {
      var classMirror = _getClassMirror(symbol, _searchLibraries);

      converter = _converterClassMirror.newInstance(new Symbol(''), [this, classMirror]).reflectee;

      _converters[symbol] = converter;
    }

    return converter;
  }
}
