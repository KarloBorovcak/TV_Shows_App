// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Show _$ShowFromJson(Map<String, dynamic> json) => Show(
      json['title'] as String,
      json['description'] as String,
      json['no_of_reviews'] as int,
      (json['average_rating'] as num).toDouble(),
      json['image_url'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'no_of_reviews': instance.noOfReviews,
      'average_rating': instance.averageRating,
      'image_url': instance.imageUrl,
      'id': instance.id,
    };
