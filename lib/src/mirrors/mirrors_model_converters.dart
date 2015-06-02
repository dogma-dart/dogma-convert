// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma_data.mirrors;

abstract class _MirrorsModelConverters<Converter> {
  static const _defaultConstructor = const Symbol('');

  final ClassMirror _converterClassMirror;
  final ClassMirror _converterInterfaceClassMirror;
  final ClassMirror _compositeConverterClassMirror;
  final Map<Symbol, Converter> _converters = new Map<Symbol, Converter>();
  final List<LibraryMirror> _searchLibraries;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  _MirrorsModelConverters._internal(this._converterClassMirror,
                               this._converterInterfaceClassMirror,
                               this._compositeConverterClassMirror,
                               this._searchLibraries);

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
      // Get the class mirror for the symbol
      var classMirror = _getClassMirror(symbol, _searchLibraries);

      converter = _converterClassMirror.newInstance(_defaultConstructor, [this, classMirror]).reflectee;

      // Determine if there are any custom converters
      var converterMirrors = getClassConvertersOfType(symbol, _converterInterfaceClassMirror.simpleName, _searchLibraries);

      if (converterMirrors.length > 0) {
        var converters = [ converter ];

        for (var converterMirror in converterMirrors) {
          var instance = converterMirror.newInstance(_defaultConstructor, []).reflectee;

          converters.add(instance);
        }

        converter = _compositeConverterClassMirror.newInstance(_defaultConstructor, [ converters ]).reflectee;
      }

      _converters[symbol] = converter;
    }

    return converter;
  }
}
