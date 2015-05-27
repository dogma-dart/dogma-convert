// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.data.src.mirrors.mirrors_converters;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'mirrors_helpers.dart';
import 'symbol_helpers.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------


abstract class MirrorsConverters<Converter> {
  final ClassMirror _converterClassMirror;
  final Map<Symbol, Converter> _converters = new Map<Symbol, Converter>();
  final List<LibraryMirror> _searchLibraries;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  MirrorsConverters(this._converterClassMirror, this._searchLibraries);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      var classSymbol = symbolToUppercase(invocation.memberName);
      var decoder = getConverter(new Symbol(classSymbol));

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
  // Protected methods
  //---------------------------------------------------------------------

  Converter getConverter(Symbol symbol) {
    var converter = _converters[symbol];

    if (converter == null) {
      var classMirror = getClassMirror(symbol, _searchLibraries);

      converter = _converterClassMirror.newInstance(new Symbol(''), [this, classMirror]).reflectee;

      _converters[symbol] = converter;
    }

    return converter;
  }
}
