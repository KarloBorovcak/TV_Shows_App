import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tv_shows/models/register_info.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/signin_info.dart';
import 'package:tv_shows/utilities/auth_info.dart';
import 'package:tv_shows/utilities/auth_info_holder.dart';
import 'package:tv_shows/utilities/auth_info_interceptor.dart';
import 'package:tv_shows/utilities/error_extractor_interceptor.dart';

import '../models/show.dart';
import '../models/user.dart';

class NetworkingRepository {
  NetworkingRepository(this.authInfoHolder) {
    final options = BaseOptions(baseUrl: 'https://tv-shows.infinum.academy');
    _dio = Dio(options);
    _dio.interceptors.addAll(
      [
        AuthInfoInterceptor(authInfoHolder),
        ErrorExtractorInterceptor(),
      ],
    );
  }
  late final Dio _dio;
  final AuthInfoHolder authInfoHolder;

  Future<User> registerUser(RegisterInfo registerInfo) async {
    final response = await _dio.post('/users', data: registerInfo.toJson());
    authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);
    final json = jsonDecode(response.data);
    return User.fromJson(json);
  }

  Future<User> signInUser(SignInInfo signInInfo) async {
    final response = await _dio.post('/users/sign_in', data: signInInfo.toJson());
    authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);
    final json = jsonDecode(response.data);
    return User.fromJson(json);
  }

  Future<List<Show>> fetchShows() async {
    final response = await _dio.get('/shows');
    final json = jsonDecode(response.data);
    var pomList = json['shows'];

    return pomList.map((json) => Show.fromJson(json));
  }

  Future<List<Review>> fetchReviews(int id) async {
    final response = await _dio.post('/show/$id/reviews');
    final json = jsonDecode(response.data);
    var pomList = json['reviews'];

    return pomList.map((json) => Review.fromJson(json));
  }
}
