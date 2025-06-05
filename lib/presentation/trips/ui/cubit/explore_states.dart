import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import 'package:travel/presentation/trips/domain/Entity/hotels_response_entity.dart';

abstract class TripsStates{}
class InitState extends TripsStates{}
class LoadingState extends TripsStates{}
class SuccessState extends TripsStates{
  List<ExploreResponseEntity> response;
  SuccessState({required this.response});
}
class ErrorState extends TripsStates{
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
