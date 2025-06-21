import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/common/dialog_utils.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/book_now_states.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/book_view_model.dart';

class BookNow extends StatefulWidget {
  final String tripId, type;

  const BookNow({super.key, required this.tripId, required this.type});

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  @override
  Widget build(BuildContext context) {
    final bookNowViewModel = BlocProvider.of<BookNowViewModel>(context);

    return BlocListener<BookNowViewModel, BookNowStates>(
      bloc: bookNowViewModel,
      listener: (context, state) {
        if (state is BookNowSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: state.bookNowResponseEntity.message ?? "Thanks",
            posActionName: 'ok',
          );
        } else if (state is BookNowErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: "Error",
            message: state.errorMessage ?? " ",
            posActionName: 'ok',
          );
        } else {
          DialogUtils.showLoading(context: context);
        }
      },
      child: ElevatedButton(
        onPressed: () {
          DialogUtils.showMessage(
            context: context,
            title: 'Booking Steps',
            message: 'Are you Sure you wanna book this Tour',
            posActionName: 'Book',
            negActionName: 'Cancel',
            posAction: () => bookNowViewModel.bookNow(widget.tripId, widget.type),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
        child: const Text("Book Now"),
      ),
    );
  }
}
