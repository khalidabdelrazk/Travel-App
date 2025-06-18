import 'package:travel/presentation/explore%20details/domain/Entity/fav_response_entity.dart';

abstract class TripDetailsStates {}

class DetailsInitState extends TripDetailsStates {}

class DetailsLoadingState extends TripDetailsStates {}

class DetailsSuccessState extends TripDetailsStates {
  FavResponseEntity response;
  DetailsSuccessState({required this.response});
}

class DetailsErrorState extends TripDetailsStates {
  String errorMessage;
  DetailsErrorState({required this.errorMessage});
}

class FavOrNotState extends TripDetailsStates {
  bool isFav;
  FavOrNotState({required this.isFav});
}
