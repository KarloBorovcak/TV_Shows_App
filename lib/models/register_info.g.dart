// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInfo _$RegisterInfoFromJson(Map<String, dynamic> json) => RegisterInfo(
      json['email'] as String,
      json['password'] as String,
      json['password_confirmation'] as String,
    );

Map<String, dynamic> _$RegisterInfoToJson(RegisterInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };
