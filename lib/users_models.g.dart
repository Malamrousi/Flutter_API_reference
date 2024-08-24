// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersModels _$UsersModelsFromJson(Map<String, dynamic> json) => UsersModels(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UsersModelsToJson(UsersModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'status': instance.status,
    };
