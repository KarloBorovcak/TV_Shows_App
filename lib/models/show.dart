import 'package:json_annotation/json_annotation.dart';

part 'show.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Show {
  Show(this.title, this.description, this.noOfReviews, this.averageRating, this.imageUrl, this.id);
  String title;
  String description;
  int noOfReviews;
  double averageRating;
  String imageUrl;
  int id;

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
  Map<String, dynamic> toJson() => _$ShowToJson(this);
}
