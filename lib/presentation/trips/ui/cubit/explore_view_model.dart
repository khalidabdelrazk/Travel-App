

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/Use Case/hotels_use_case.dart';
import '../../domain/Use Case/trips_use_case.dart';
import 'explore_states.dart';

@injectable
class ExploreViewModel extends Cubit<ExploreStates> {
  HotelsUseCase hotelsUseCase;
  TripsUseCase tripsUseCase;
  ExploreViewModel({required this.hotelsUseCase, required this.tripsUseCase})
    : super(InitState());

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
