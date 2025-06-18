import 'package:travel/presentation/administrator/domain/Entity/administrator_response_entity.dart';

abstract class AdministratorStates {}

class InitState extends AdministratorStates {}

class LoadingState extends AdministratorStates {}

class SuccessState extends AdministratorStates {
  TourResponseEntity tourResponseEntity;
  SuccessState({required this.tourResponseEntity});
}

class ErrorState extends AdministratorStates {
  String errorMessage;
  ErrorState({required this.errorMessage});
}
