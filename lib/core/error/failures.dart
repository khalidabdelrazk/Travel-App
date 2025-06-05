abstract class Failures {
  final String errorMessage;
  Failures({required this.errorMessage});
}

class ServerError extends Failures {
  ServerError({required super.errorMessage});
}

class NetworkError extends Failures {
  NetworkError({required super.errorMessage});
}
