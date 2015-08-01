// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_data.bin.generate;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:io';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:args/args.dart';
import 'package:dogma_data/build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Prints how to use the script.
void _printUsage(ArgParser parser, [String error]) {
  var output = stdout;

  var message = 'Generates model code in this package';
  if (error != null) {
    message = error;
    output = stderr;
  }

  output.write('''$message
Usage: pub run dogma_data:generate [file]
${parser.usage}
''');
}

void main(List<String> args) {
  // Parse the arguments
  var parser = new ArgParser()
      ..addFlag('unmodifiable', defaultsTo: true)
      ..addFlag('converters', defaultsTo: true);

  var parsed = parser.parse(args);
  var rest = parsed.rest;

  // Check to see if a file was specified
  if (rest.isEmpty) {
    _printUsage(parser, 'No file specified!');
    return;
  }

  build([], 'test', rest[0]);
}
