import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/domain/Use%20Case/trip_details_use_case.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_states.dart';
import 'package:travel/presentation/wishlist/domain/Use%20Case/wishlist_use_case.dart';

@injectable
class TripDetailsViewModel extends Cubit<TripDetailsStates> {
  TripDetailsUseCase tripDetailsUseCase;
  WishlistUseCase wishlistUseCase;

  TripDetailsViewModel({
    required this.tripDetailsUseCase,
    required this.wishlistUseCase,
  }) : super(DetailsInitState());

  bool toggleFav = false;

  void addToFav(String tripId, bool setFav) async {
    emit(DetailsLoadingState());
    var either = await tripDetailsUseCase.invoke(tripId, setFav);
    either.fold(
      (left) => emit(DetailsErrorState(errorMessage: left.errorMessage)),
      (right) => emit(DetailsSuccessState(response: right)),
    );
  }

  Future<bool> isTripFav(String tripId) async {
    emit(DetailsLoadingState());
    var either = await wishlistUseCase.invoke();

    return either.fold(
      (left) {
        emit(DetailsErrorState(errorMessage: left.errorMessage));
        return false;
      },
      (right) {
        toggleFav = right.any((element) => element.id == tripId);
        emit(FavOrNotState(isFav: toggleFav));
        return toggleFav;
      },
    );
  }
}
