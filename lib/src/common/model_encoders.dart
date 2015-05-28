// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelEncoders] interface.
library dogma_data.src.common.model_encoders;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An interface to query a [ModelEncoder].
///
///     var personEncoder = modelEncoders.person as ModelEncoder<Person>;
///
///     var data = personDecoder.convert(person);
@proxy
class ModelEncoders {}
