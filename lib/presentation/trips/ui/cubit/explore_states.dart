import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';


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