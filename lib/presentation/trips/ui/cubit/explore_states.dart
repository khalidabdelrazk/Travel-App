import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';

abstract class ExploreStates{}
class InitState extends ExploreStates{}
class LoadingState extends ExploreStates{}
class SuccessState extends ExploreStates{
  List<ExploreResponseEntity> response;
  SuccessState({required this.response});
}
class ErrorState extends ExploreStates{
  String errorMessage;
  ErrorState({required this.errorMessage});
}

// abstract class RegisterStates {}
//
// class InitState extends RegisterStates{}
//
// class ShowLoading extends RegisterStates {}
//
// class SuccessState extends RegisterStates {
//   RegisterResponseEntity registerResponseEntity;
//   SuccessState(this.registerResponseEntity);
// }
//
// class ErrorState extends RegisterStates {
//   String errorMessage;
//   ErrorState(this.errorMessage);
// }
