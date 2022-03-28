import 'package:json_annotation/json_annotation.dart';

part 'register_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterInfo {
  RegisterInfo(this.email, this.password, this.passwordConfirmation);
  final String email;
  final String password;
  final String passwordConfirmation;

  factory RegisterInfo.fromJson(Map<String, dynamic> json) => _$RegisterInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterInfoToJson(this);
}
