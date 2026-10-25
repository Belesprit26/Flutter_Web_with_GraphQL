// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:graphql_api/schema/__generated__/schema.schema.gql.dart' as _i2;
import 'package:graphql_api/schema/__generated__/serializers.gql.dart' as _i1;

part 'order.var.gql.g.dart';

abstract class GOrderDetailsVars
    implements Built<GOrderDetailsVars, GOrderDetailsVarsBuilder> {
  GOrderDetailsVars._();

  factory GOrderDetailsVars(
          [void Function(GOrderDetailsVarsBuilder b) updates]) =
      _$GOrderDetailsVars;

  String get id;
  static Serializer<GOrderDetailsVars> get serializer =>
      _$gOrderDetailsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderDetailsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderDetailsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderDetailsVars.serializer,
        json,
      );
}

abstract class GCreateOrderVars
    implements Built<GCreateOrderVars, GCreateOrderVarsBuilder> {
  GCreateOrderVars._();

  factory GCreateOrderVars([void Function(GCreateOrderVarsBuilder b) updates]) =
      _$GCreateOrderVars;

  _i2.GCreateOrderInput get input;
  static Serializer<GCreateOrderVars> get serializer =>
      _$gCreateOrderVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateOrderVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateOrderVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateOrderVars.serializer,
        json,
      );
}

abstract class GOrderUpdatedVars
    implements Built<GOrderUpdatedVars, GOrderUpdatedVarsBuilder> {
  GOrderUpdatedVars._();

  factory GOrderUpdatedVars(
          [void Function(GOrderUpdatedVarsBuilder b) updates]) =
      _$GOrderUpdatedVars;

  String get id;
  static Serializer<GOrderUpdatedVars> get serializer =>
      _$gOrderUpdatedVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderUpdatedVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderUpdatedVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderUpdatedVars.serializer,
        json,
      );
}

abstract class GOrderFieldsVars
    implements Built<GOrderFieldsVars, GOrderFieldsVarsBuilder> {
  GOrderFieldsVars._();

  factory GOrderFieldsVars([void Function(GOrderFieldsVarsBuilder b) updates]) =
      _$GOrderFieldsVars;

  static Serializer<GOrderFieldsVars> get serializer =>
      _$gOrderFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GOrderFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GOrderFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GOrderFieldsVars.serializer,
        json,
      );
}
