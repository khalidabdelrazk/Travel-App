import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';

abstract class MostPopularStates {}

class MostPopularInitState extends MostPopularStates {}

class MostPopularErrorState extends MostPopularStates {
  dynamic errorMsg;
  MostPopularErrorState({required this.errorMsg});
}

class MostPopularLoading extends MostPopularStates {}

class PopularSuccess extends MostPopularStates {
  final List<HomeTripsResponseEntity> response;
  PopularSuccess(this.response);
}
