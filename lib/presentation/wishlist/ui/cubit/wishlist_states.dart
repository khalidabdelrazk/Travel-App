import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';

abstract class WishListStates {}

class InitState extends WishListStates {}

class LoadingState extends WishListStates {}

class SuccessState extends WishListStates {}

class ErrorState extends WishListStates {
  String errorMessage;
  ErrorState({required this.errorMessage});
}
