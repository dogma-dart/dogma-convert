// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of dogma.data.mirrors;

String _parseSymbol(Symbol symbol) {
  var symbolString = symbol.toString();

  var start = symbolString.indexOf('"');
  var end = symbolString.lastIndexOf('"');

  return symbolString.substring(start + 1, end);
}

String _symbolToUppercase(Symbol symbol) {
  var codeUnits = new List<int>.from(_parseSymbol(symbol).codeUnits);

  codeUnits[0] = codeUnits[0] - 32;

  return new String.fromCharCodes(codeUnits);
}
