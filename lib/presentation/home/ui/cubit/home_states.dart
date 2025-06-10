import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';

abstract class HomeStates{}
class InitState extends HomeStates{}
class LoadingState extends HomeStates{}
class SuccessState extends HomeStates{
  List<HomeTripsResponseEntity> response;
  SuccessState({required this.response});
}
class ErrorState extends HomeStates{
  String errorMessage;
  ErrorState({required this.errorMessage});
}