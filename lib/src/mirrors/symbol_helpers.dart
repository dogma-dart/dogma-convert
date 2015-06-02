// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains functions for working with [Symbol]s.
library dogma_data.src.mirrors.symbol_helpers;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Parses a [symbol] into a string.
///
/// The toString method on [Symbol] puts quotation marks around the name of the
/// symbol. This function returns the actual symbol name by removing the
/// quotation marks.
String parseSymbol(Symbol symbol) {
  var symbolString = symbol.toString();

  var start = symbolString.indexOf('"');
  var end = symbolString.lastIndexOf('"');

  return symbolString.substring(start + 1, end);
}

/// Converts a [symbol] in camel case into pascal case.
///
/// Pascal case always begins with a capital letter, while camel case begins
/// with a lower case letter. The function gets the symbol as a string and then
/// converts the first letter to be upper case.
String camelToPascalCase(Symbol symbol) {
  var codeUnits = new List<int>.from(parseSymbol(symbol).codeUnits);

  codeUnits[0] = codeUnits[0] - 32;

  return new String.fromCharCodes(codeUnits);
}
