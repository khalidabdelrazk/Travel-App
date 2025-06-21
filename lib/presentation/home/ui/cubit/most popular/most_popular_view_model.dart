import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/Entity/trips_response_entity.dart';
import '../../../domain/Use Case/home_trips_use_case.dart';
import 'most_popular_states.dart';

@injectable
class MostPopularViewModel extends Cubit<MostPopularStates> {
  HomeTripsUseCase homeTripsUseCase;

  List<HomeTripsResponseEntity> mostPopTrips = [];

  MostPopularViewModel({required this.homeTripsUseCase})
    : super(MostPopularInitState());

  void getTrips() async {
    emit(MostPopularLoading());
    var either = await homeTripsUseCase.invoke();
    either.fold(
      (left) => emit(MostPopularErrorState(errorMsg: left.errorMessage)),
      (right) {
        mostPopTrips = right;
        emit(PopularSuccess(right));
      },
    );
  }
}
