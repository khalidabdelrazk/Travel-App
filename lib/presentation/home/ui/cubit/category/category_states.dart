import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';

abstract class CategoryStates {}

class CategoryInitState extends CategoryStates {}

class CategoryErrorState extends CategoryStates {
  dynamic errorMsg;
  CategoryErrorState({required this.errorMsg});
}

class CategoryLoading extends CategoryStates {
  final String category;
  CategoryLoading(this.category);
}

class CategorySuccess extends CategoryStates {
  final String category;
  final List<HomeTripsResponseEntity> items;
  CategorySuccess({required this.category, required this.items});
}
