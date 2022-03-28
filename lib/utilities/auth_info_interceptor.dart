import 'package:dio/dio.dart';
import 'package:tv_shows/utilities/auth_info_holder.dart';

class AuthInfoInterceptor extends Interceptor {
  AuthInfoHolder authInfoHolder;
  AuthInfoInterceptor(this.authInfoHolder);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authInfoHolder.authInfo != null) {
      options.headers.addAll(authInfoHolder.authInfo!.toHeaders());
    }
    super.onRequest(options, handler);
  }
}
