import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/Entity/trips_response_entity.dart';
import '../../../domain/Use Case/category_use_case.dart';
import 'category_states.dart';

@injectable
class CategoryViewModel extends Cubit<CategoryStates> {
  CategoryUseCase categoryUseCase;

  late Map<String, List<HomeTripsResponseEntity>> categories = {
    "beach": [],
    "mountain": [],
    "ancient": [],
    "wonder": [],
  };

  CategoryViewModel({required this.categoryUseCase})
    : super(CategoryInitState());

  void getCategoryTrips(String queryParams) async {
    emit(CategoryLoading(queryParams));
    var either = await categoryUseCase.invoke(queryParams);
    either.fold(
      (left) => emit(CategoryErrorState(errorMsg: left.errorMessage)),
      (right) {
        categories[queryParams] = right;
        emit(CategorySuccess(category: queryParams, items: right));
      },
    );
  }
}
