import 'package:dio/dio.dart';
import 'package:tv_shows/utilities/storage_repository.dart';

class AuthInfoInterceptor extends Interceptor {
  StorageRepository authInfoHolder;
  AuthInfoInterceptor(this.authInfoHolder);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var authInfo = await authInfoHolder.getAuthInfo;
    if (authInfo != null) {
      options.headers.addAll(authInfo.toHeaders());
    }
    super.onRequest(options, handler);
  }
}
