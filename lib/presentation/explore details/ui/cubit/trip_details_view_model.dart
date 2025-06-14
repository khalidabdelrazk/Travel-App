import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/domain/Use%20Case/trip_details_use_case.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_states.dart';



@injectable
class TripDetailsViewModel extends Cubit<TripDetailsStates> {
  TripDetailsUseCase tripDetailsUseCase;
  TripDetailsViewModel({required this.tripDetailsUseCase})
    : super(DetailsInitState());

  void addToFav(String tripId, bool setFav) async {
    emit(DetailsLoadingState());
    var either = await tripDetailsUseCase.invoke(tripId, setFav);
    either.fold(
      (left) => emit(DetailsErrorState(errorMessage: left.errorMessage)),
      (right) => emit(DetailsSuccessState(response: right)),
    );
  }

}
