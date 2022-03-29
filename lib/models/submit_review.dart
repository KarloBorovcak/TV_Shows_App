import 'package:json_annotation/json_annotation.dart';

part 'submit_review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubmitReview {
  SubmitReview(this.comment, this.rating, this.showId);

  String? comment;
  int rating;
  int showId;

  factory SubmitReview.fromJson(Map<String, dynamic> json) => _$SubmitReviewFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitReviewToJson(this);
}
