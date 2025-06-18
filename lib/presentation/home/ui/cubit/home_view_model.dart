import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/home/ui/cubit/home_states.dart';

import '../../domain/Entity/trips_response_entity.dart';
import '../../domain/Use Case/category_use_case.dart';
import '../../domain/Use Case/home_trips_use_case.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  HomeTripsUseCase homeTripsUseCase;
  CategoryUseCase categoryUseCase;

  List<HomeTripsResponseEntity> mostPopularTrips = [];
  late Map<String, List<HomeTripsResponseEntity>> categories = {
    "beach": [],
    "mountain": [],
    "ancient": [],
    "wonder": [],
  };
  List<HomeTripsResponseEntity> mostPopTrips = [];

  HomeViewModel({required this.homeTripsUseCase, required this.categoryUseCase})
    : super(InitState());

  void getTrips() async {
    emit(PopularLoading());
    var either = await homeTripsUseCase.invoke();
    either.fold((left) => emit(ErrorState(errorMsg: left.errorMessage)), (
      right,
    ) {
      mostPopTrips = right;
      emit(PopularSuccess(right));
    });
  }

  void getCategoryTrips(String queryParams) async {
    emit(CategoryLoading(queryParams));
    var either = await categoryUseCase.invoke(queryParams);
    either.fold((left) => emit(ErrorState(errorMsg: left.errorMessage)), (
      right,
    ) {
      categories[queryParams] = right;
      emit(CategorySuccess(category: queryParams, items: right));
    });
  }
}
