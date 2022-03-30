// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitReview _$SubmitReviewFromJson(Map<String, dynamic> json) => SubmitReview(
      json['comment'] as String?,
      json['rating'] as int,
      json['show_id'] as int,
    );

Map<String, dynamic> _$SubmitReviewToJson(SubmitReview instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'rating': instance.rating,
      'show_id': instance.showId,
    };
