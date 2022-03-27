// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['comment'] as String?,
      json['rating'] as int,
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['id'] as String,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'comment': instance.comment,
      'rating': instance.rating,
      'id': instance.id,
      'user': instance.user,
    };
