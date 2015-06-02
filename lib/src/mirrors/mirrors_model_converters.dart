// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [MirrorsModelConverters] class.
library dogma_data.src.mirrors.mirrors_model_converters;

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

/// Base class for retrieving a [Converter].
///
/// The [MirrorsModelConverters] can generate [Converter]s through the mirrors
/// interface.
abstract class MirrorsModelConverters<Converter> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Symbol for the default constructor.
  static const _defaultConstructor = const Symbol('');

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final ClassMirror _converterClassMirror;
  final ClassMirror _converterInterfaceClassMirror;
  final ClassMirror _compositeConverterClassMirror;
  final Map<Symbol, Converter> _converters = new Map<Symbol, Converter>();
  final List<LibraryMirror> _searchLibraries;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  MirrorsModelConverters(this._converterClassMirror,
                         this._converterInterfaceClassMirror,
                         this._compositeConverterClassMirror,
                         this._searchLibraries);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      var classSymbol = camelToPascalCase(invocation.memberName);
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

  /// Retrieves a converter with the given [symbol].
  ///
  /// Warning! For internal use only by subclasses.
  Converter getConverter(Symbol symbol) {
    var converter = _converters[symbol];

    if (converter == null) {
      // Get the class mirror for the symbol
      var classMirror = getClassMirror(symbol, _searchLibraries);

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
