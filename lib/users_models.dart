// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'users_models.g.dart';

@JsonSerializable()
class UsersModels {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String status;

 

  UsersModels({
   required this.id,
   required this.name,
   required this.email,
  required  this.gender,
  required  this.status,
  });

  factory UsersModels.fromJson(Map<String, dynamic> json) =>
      _$UsersModelsFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelsToJson(this);
}


