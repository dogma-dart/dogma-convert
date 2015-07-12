// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelEncoders] interface.
library dogma_data.src.data.model_encoders;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An interface to query a [ModelEncoder].
///
/// An instance of [ModelEncoders] will contain all the [ModelEncoder]s for a
/// given library. The individual encoders are available through getters on the
/// instance. By convention they are the class name converted to camel-case.
///
/// As an example the following gets a [ModelEncoder] which encodes data from a
/// Person instance.
///
///     var personEncoder = modelEncoders.person as ModelEncoder<Person>;
///
///     var data = personDecoder.convert(person);
///
/// It is recommended that a cast be used so the analyzer knows the proper type
/// as the base implementation of [ModelEncoders] uses the proxy annotation to
/// remove any warnings. This is because of the mirrors implementation which
/// functions through noSuchMethod.
@proxy
class ModelEncoders {}
