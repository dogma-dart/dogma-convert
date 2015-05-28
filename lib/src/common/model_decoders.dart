// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelDecoders] interface.
library dogma_data.src.common.model_decoders;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An interface to retrieve the [ModelDecoder]s in a library.
///
///     var personDecoder = modelDecoders.person as ModelDecoder<Person>;
///
///     var person = personDecoder.convert(data);
@proxy
class ModelDecoders {}
