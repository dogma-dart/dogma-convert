// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [SerializationValues] annotation.
library dogma_data.src.common.serialization_values;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata for specifying the mapping for an enumeration.
///
/// The [SerializationValues] annotation specifies what value should map to an
/// enumeration. The key should be either a [String] or an [int] that
/// corresponds to the value.
///
///     @SerializationValues(colorValues)
///     enum Color {
///       red,
///       green,
///       blue
///     }
///
///     const Map colorValues = const {
///       'r': Color.red,
///       'g': Color.green,
///       'b': Color.blue
///     };
///
/// Currently enumeration values cannot be annotated. Because of this a more
/// verbose version is being used. If this restriction is lifted then the
/// [SerializationValues] annotation will be replaced with annotating the value
/// directly on the values.
///
/// Please star [https://code.google.com/p/dart/issues/detail?id=23441](issue
/// 23441) to follow progress.
class SerializationValues {
  /// The value to check for.
  final Map values;

  const SerializationValues(this.values);
}
