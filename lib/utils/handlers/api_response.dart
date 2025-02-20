import 'package:qoruz/utils/constants/enums.dart' show Status;

/// A generic class that holds the API response.
class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message) : status = Status.initial;
  ApiResponse.loading(this.message) : status = Status.loading;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}
