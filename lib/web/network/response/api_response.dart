import 'package:mydemomvvm/web/network/response/status.dart';

class APIResponse<T> {
  Status? status;
  T? data;
  String? message;

  APIResponse(this.status, this.data, this.message);

  APIResponse.completed():status = Status.COMPLETED;
  APIResponse.loading(): status = Status.LOADING;
  APIResponse.error():status = Status.ERROR;

  @override
  String toString(){
    return "Status: $status \n Message : $message \n Data : $data";
  }
}
