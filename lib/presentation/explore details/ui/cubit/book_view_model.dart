import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/Use Case/book_now_use_case.dart';
import 'book_now_states.dart';

@injectable
class BookNowViewModel extends Cubit<BookNowStates> {
  BookNowUseCase bookNowUseCase;

  BookNowViewModel({
    required this.bookNowUseCase,
  }) : super(BookNowInitState());


  Future<void> bookNow(String tripId, String type) async {
    print("Book Now triggered for $tripId of type $type"); // Add this
    emit(BookNowLoadingState());
    var either = await bookNowUseCase.invoke(tripId, type);
    either.fold(
          (left) => emit(BookNowErrorState(errorMessage: left.errorMessage)),
          (right) => emit(BookNowSuccessState(bookNowResponseEntity: right)),
    );
  }
}
