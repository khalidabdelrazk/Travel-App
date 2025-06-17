import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/explore%20details/domain/Use%20Case/trip_details_use_case.dart';
import 'package:travel/presentation/wishlist/domain/Entity/wishlist_response_entity.dart';

import '../../domain/Use Case/wishlist_use_case.dart';
import 'wishlist_states.dart';

@injectable
class WishlistViewModel extends Cubit<WishListStates> {
  final WishlistUseCase wishlistUseCase;
  final TripDetailsUseCase tripDetailsUseCase;
  List<WishlistResponseEntity> wishlist = [];


  WishlistViewModel({
    required this.wishlistUseCase,
    required this.tripDetailsUseCase,
  }) : super(InitState());

  Future<void> getWishlist() async {
    emit(LoadingState());
    var either = await wishlistUseCase.invoke();
    either.fold(
      (left) => emit(ErrorState(errorMessage: left.errorMessage)),
      (right) {
        wishlist = right;
        emit(SuccessState());
      },
    );
  }

  Future<void> removeFromWishList(String tripId) async {
    final either = await tripDetailsUseCase.invoke(tripId, false);
    either.fold(
          (left) => emit(ErrorState(errorMessage: left.errorMessage)),
          (right) {
            if(wishlist.length == 1){
              wishlist.removeWhere((trip) => trip.id == tripId);
              getWishlist();
              return;
            }
        wishlist.removeWhere((trip) => trip.id == tripId);
        emit(SuccessState());
      },
    );
  }
}
