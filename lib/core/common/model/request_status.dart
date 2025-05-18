enum RequestState { idle, loading, success, error, empty }

class RequestStatus<T> {
  final RequestState state;
  final T? data;
  final String? error;

  const RequestStatus._(this.state, {this.data, this.error});

  const RequestStatus.idle() : this._(RequestState.idle);
  const RequestStatus.loading() : this._(RequestState.loading);
  const RequestStatus.success({T? data}) : this._(RequestState.success, data: data);
  const RequestStatus.error(String error) : this._(RequestState.error, error: error);
  const RequestStatus.empty() : this._(RequestState.empty);

  bool get isLoading => state == RequestState.loading;
  bool get isSuccess => state == RequestState.success;
  bool get isError => state == RequestState.error;
  bool get isIdle => state == RequestState.idle;
  bool get isEmpty => state == RequestState.empty;
}