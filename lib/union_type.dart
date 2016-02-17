// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [UnionType] annotation.
///
/// The [UnionType] annotation is used to give more information on what a value
/// typed as `dynamic` could be.
///
/// In the case of Dogma's code generation this value can be used to guide the
/// serialization process. As an example if an API will return either an `int`
/// or `String` then it would be declared as follows.
///
///     import 'package:dogma_convert/union_type.dart';
///
///     class Foo {
///       @UnionType(const ['int', 'String'])
///       dynamic bar;
///     }
///
/// When the code is generated for serializing the value then the code
/// generation knows that the Map value can be used directly. Without the
/// annotation the safety of the operation is unknown.
library dogma_convert.union_type;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata for specifying the union of multiple types.
class UnionType {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The types that the annotated value could be.
  final List<String> types;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [UnionType] which is the union of the given
  /// [types].
  const UnionType(this.types);
}
