import 'package:json_annotation/json_annotation.dart';
import 'package:tv_shows/models/user.dart';

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Review {
  Review(this.comment, this.rating, this.user, this.id);

  String? comment;
  int rating;
  int id;
  User user;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
