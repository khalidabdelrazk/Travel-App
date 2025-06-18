import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/administrator/domain/Use%20Case/administrator_use_case.dart';
import 'package:travel/presentation/administrator/ui/cubit/administrator_states.dart';

@injectable
class AdministratorViewModel extends Cubit<AdministratorStates> {
  AdministratorUseCase administratorUseCase;

  AdministratorViewModel({required this.administratorUseCase})
    : super(InitState());

  // todo : data =>>>
  final formKey = GlobalKey<FormState>();

  final List<String> types = [
    'ancient',
    'wonder',
    'beach',
    'mountain',
    'hotel',
  ];
  final List<File> pickedImages = [];

  String? selectedType;
  double? rating;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // todo : Function
  void postTrip() async {
    if (formKey.currentState?.validate() == true &&
        selectedType != null &&
        rating != null &&
        pickedImages.length >= 2) {
      emit(LoadingState());
      var either = await administratorUseCase.invoke(
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        location: locationController.text,
        city: cityController.text,
        type: selectedType!,
        rating: rating!,
        photos: pickedImages,
      );
      either.fold(
        (left) => emit(ErrorState(errorMessage: left.errorMessage)),
        (right) => emit(SuccessState(tourResponseEntity: right)),
      );
    }
  }
}
