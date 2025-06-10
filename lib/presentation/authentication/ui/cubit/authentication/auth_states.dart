abstract class AuthStates {}

class InitState extends AuthStates {}

class ShowLoading extends AuthStates {}

class SuccessState extends AuthStates {
  dynamic response;
  SuccessState({required this.response});
}

class ErrorState extends AuthStates {
  String errorMessage;
  ErrorState({required this.errorMessage});
}
