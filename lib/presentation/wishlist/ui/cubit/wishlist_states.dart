
abstract class WishListStates {}

class InitState extends WishListStates {}

class LoadingState extends WishListStates {}

class SuccessState extends WishListStates {}

class ErrorState extends WishListStates {
  String errorMessage;
  ErrorState({required this.errorMessage});
}
