import 'package:json_annotation/json_annotation.dart';

part 'signin_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SignInInfo {
  SignInInfo(this.email, this.password);
  final String email;
  final String password;

  factory SignInInfo.fromJson(Map<String, dynamic> json) => _$SignInInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SignInInfoToJson(this);
}
