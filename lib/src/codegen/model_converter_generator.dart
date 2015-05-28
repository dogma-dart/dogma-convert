// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [ModelConverterGenerator] class.
library dogma_data.src.codegen.model_converter_generator;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/element.dart';

import 'codegen_helpers.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Base class for the conversion generators.
abstract class ModelConverterGenerator {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The class element being targeted.
  final ClassElement element;
  /// The declaration of the class element.
  final ClassDeclaration declaration;

  /// The serializable fields.
  final Map<String, FieldElement> serializableFields = new Map<String, FieldElement>();

  /// The dependencies for the generator.
  ///
  ///
  final Set<DartType> dependencies = new Set<DartType>();

  ModelConverterGenerator(this.element, this.declaration) {
    _populate();
  }

  /// Generates the source code for the converter and writes it to the [buffer].
  void write(StringBuffer buffer);

  void _populate() {
    // Get the serializable fields
    var fields = (hasSerializationAnnotations(element))
        ? getAnnotatedSerializableFields(element, declaration, true)
        : getSerializableFields(element);

    serializableFields.addAll(fields);

    // Get the dependencies for the decoder
    serializableFields.forEach((key, value) {
      var check = value.type;

      if (isListType(check)) {
        check = check.typeArguments[0];
      }

      if (!isBuiltinType(check)) {
        dependencies.add(check);
      }
    });
  }
}
