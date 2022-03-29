import 'package:dio/dio.dart';
import 'package:tv_shows/models/register_info.dart';
import 'package:tv_shows/models/review.dart';
import 'package:tv_shows/models/signin_info.dart';
import 'package:tv_shows/models/submit_review.dart';
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
    return User.fromJson(response.data['user']);
  }

  Future<User> signInUser(SignInInfo signInInfo) async {
    final response = await _dio.post('/users/sign_in', data: signInInfo.toJson());
    authInfoHolder.authInfo = AuthInfo.fromHeaderMap(response.headers.map);
    return User.fromJson(response.data['user']);
  }

  Future<List<Show>> fetchShows() async {
    final response = await _dio.get('/shows');
    var pomList = response.data['shows'];

    return (pomList as List).map((json) => Show.fromJson(json)).toList();
  }

  Future<List<Review>> fetchReviews(String id) async {
    final response = await _dio.get('/shows/$id/reviews');
    var pomList = response.data['reviews'];

    return (pomList as List).map((json) => Review.fromJson(json)).toList();
  }

  void submitReview(SubmitReview review) async {
    await _dio.post('/reviews', data: review.toJson());
  }
}
