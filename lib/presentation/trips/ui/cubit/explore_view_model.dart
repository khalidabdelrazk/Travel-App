import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/trips/domain/Use%20Case/trips_use_case.dart';
import 'package:travel/presentation/trips/ui/cubit/explore_states.dart';

import '../../domain/Use Case/hotels_use_case.dart';

@injectable
class ExploreViewModel extends Cubit<TripsStates> {
  HotelsUseCase hotelsUseCase;
  TripsUseCase tripsUseCase;
  ExploreViewModel({required this.hotelsUseCase, required this.tripsUseCase})
    : super(InitState());
  TextEditingController searchController = TextEditingController();

  void getHotels(String controllerText) async {
    emit(LoadingState());
    var either = await hotelsUseCase.invoke(controllerText);
    either.fold(
      (left) => emit(ErrorState(errorMessage: left.errorMessage)),
      (right) => emit(SuccessState(response: right)),
    );
  }

  void getTrips(String controllerText) async {
    emit(LoadingState());
    var either = await tripsUseCase.invoke(controllerText);
    either.fold(
      (left) => emit(ErrorState(errorMessage: left.errorMessage)),
      (right) => emit(SuccessState(response: right)),
    );
  }
}
