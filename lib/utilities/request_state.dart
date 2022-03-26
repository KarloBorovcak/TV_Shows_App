import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_state.freezed.dart';

@freezed
class RequestState<Value, Error extends Exception> with _$RequestState<Value, Error> {
  const factory RequestState.initial() = RequestStateInitial<Value, Error>;
  const factory RequestState.loading() = RequestStateLoading<Value, Error>;
  const factory RequestState.success(Value result) = RequestStateSuccess<Value, Error>;
  const factory RequestState.failure(Error error) = RequestStateFailure<Value, Error>;
}
