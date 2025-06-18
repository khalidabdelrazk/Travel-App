import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';

abstract class HomeStates{}
class InitState extends HomeStates {}
class ErrorState extends HomeStates {
  dynamic errorMsg;
  ErrorState({required this.errorMsg});
}
class PopularLoading extends HomeStates {}

class PopularSuccess extends HomeStates {
  final List<HomeTripsResponseEntity> response;
  PopularSuccess(this.response);
}

class CategoryLoading extends HomeStates {
  final String category;
  CategoryLoading(this.category);
}

class CategorySuccess extends HomeStates {
  final String category;
  final List<HomeTripsResponseEntity> items;
  CategorySuccess({required this.category, required this.items});
}
