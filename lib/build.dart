
library dogma_data.build;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:io';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:args/args.dart';
import 'package:cli_util/cli_util.dart';
import 'package:dogma_data/src/analyzer/analyzer_metadata.dart';
import 'package:dogma_data/src/analyzer/context.dart';
import 'package:dogma_data/src/codegen/library_generator.dart';
import 'package:dogma_data/src/metadata/library_metadata.dart';
import 'package:path/path.dart' as path;

Future<Null> build(List<String> args, String rootLibrary, {bool unmodifiable: true, bool converters: true}) async {
  // Parse the arguments
  var parser = new ArgParser()
      ..addFlag('machine', defaultsTo: false)
      ..addOption('changed', allowMultiple: true)
      ..addOption('removed', allowMultiple: true);

  var parsed = parser.parse(args);

  // Get the analysis context
  var context = analysisContext(path.current, getSdkDir().path);

  // Determine the caller
  //
  // If the machine flag is present then this was called by build_system and an
  // incremental build can be performed. Otherwise assume that a full rebuild
  // has been requested.
  if (parsed['machine']) {

  } else {

  }

  var metadata = libraryMetadata(rootLibrary, context);

  await _writeConverterLibrary(metadata, 'test/generated/model_explicit_converter.dart');
  await _writeUnmodifiableLibrary(metadata, 'test/generated/model_explicit.dart');
}

Future<Null> _writeConverterLibrary(LibraryMetadata metadata, String path) async {
  // Get the generated contents
  var contents = generateConverters(metadata);

  var buffer = new StringBuffer();

  var file = new File(path);

  await file.writeAsString(buffer.toString());
  await file.writeAsString(contents);
}

Future<Null> _writeUnmodifiableLibrary(LibraryMetadata metadata, String path) async {
  // Get the generated contents
  var contents = generateUnmodifiableModels(metadata);

  // Check to see if an dart:collection is required
  var usesCollection =
      contents.contains('UnmodifiableListView') ||
      contents.contains('UnmodifiableMapView');

  var buffer = new StringBuffer();

  var file = new File(path);

  await file.writeAsString(buffer.toString());
  await file.writeAsString(contents);
}
