// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelDecoders] interface.
library dogma_data.src.data.model_decoders;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An interface to retrieve the [ModelDecoder]s in a library.
///
/// An instance of [ModelDecoders] will contain all the [ModelDecoder]s for a
/// given library. The individual encoders are available through getters on the
/// instance. By convention they are the class name converted to camel-case.
///
/// As an example the following gets a [ModelDecoder] which decodes into a
/// Person instance.
///
///     var personDecoder = modelDecoders.person as ModelDecoder<Person>;
///
///     var person = personDecoder.convert(data);
///
/// It is recommended that a cast be used so the analyzer knows the proper type
/// as the base implementation of [ModelDecoders] uses the proxy annotation to
/// remove any warnings. This is because of the mirrors implementation which
/// functions through noSuchMethod.
@proxy
class ModelDecoders {}
