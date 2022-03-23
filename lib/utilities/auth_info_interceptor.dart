import 'package:dio/dio.dart';
import 'package:tv_shows/utilities/auth_info_holder.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoInterceptor(AuthInfoHolder authInfo);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }
}
