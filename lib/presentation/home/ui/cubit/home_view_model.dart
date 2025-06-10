import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/home/domain/Use%20Case/home_trips_use_case.dart';
import 'package:travel/presentation/home/ui/cubit/home_states.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  HomeTripsUseCase homeTripsUseCase;
  HomeViewModel({required this.homeTripsUseCase}) : super(InitState());

  void getTrips() async {
    emit(LoadingState());
    var either = await homeTripsUseCase.invoke();
    either.fold(
      (left) => emit(ErrorState(errorMessage: left.errorMessage)),
      (right) => emit(SuccessState(response: right)),
    );
  }
}
