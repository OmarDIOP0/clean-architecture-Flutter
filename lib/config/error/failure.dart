import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? code;
  const Failure(this.message,{this.code});

  factory Failure.httpError(int statusCode) {
    String message = "An unexpected error occurred";
    if (statusCode >= 400 && statusCode < 500) {
      message = "Client error: $statusCode";
    } else if (statusCode >= 500) {
      message = "Server error: $statusCode";
    }
    return Failure(message, code: statusCode);
  }

  @override
  List<Object?> get props => [message,code];
}

class ServerFailure extends Failure {
  const ServerFailure(String message,{int? code}) : super(message,code:code);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message,{int? code}) : super(message,code:code);
}

class DatabasesFailure extends Failure {
  const DatabasesFailure(String message ,{int? code}) : super(message,code:code);
}
