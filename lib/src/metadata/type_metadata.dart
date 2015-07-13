// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [TypeMetadata] class.
library dogma_data.src.metadata.type_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

///
class TypeMetadata extends Metadata {
  final List<TypeMetadata> arguments;

  factory TypeMetadata(String name, {List<TypeMetadata> arguments, dynamic data}) {
    if (arguments == null) {
      arguments = [];
    }

    return new TypeMetadata._internal(name, arguments, data: data);
  }

  TypeMetadata._internal(String name, this.arguments, {dynamic data})
      : super(name, data);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the type is an integer.
  bool get isInt => name == 'int';
  /// Whether the type is a double.
  bool get isDouble => name == 'double';
  /// Whether the type is a number.
  bool get isNum => isInt || isDouble;
  /// Whether the type is a boolean.
  bool get isBool => name == 'bool';
  /// Whether the type is a string.
  bool get isString => name == 'String';
  /// Whether the type is a list.
  bool get isList => name == 'List';
  /// Whether the type is a map.
  bool get isMap => name == 'Map';

  /// Whether the type is built in.
  bool get isBuiltin {
    var value;

    // Check for lists and maps as the type arguments need to be checked
    if (isList || isMap) {
      for (var argument in arguments) {
        if (!argument.isBuiltin) {
          value = false;
          break;
        }
      }

      value = true;
    } else {
      value = isNum || isBool || isString;
    }

    return value;
  }
}
