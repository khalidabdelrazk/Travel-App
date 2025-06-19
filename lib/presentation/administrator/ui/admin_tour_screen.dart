import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/core/common/dialog_utils.dart';
import 'package:travel/core/di/di.dart';
import 'package:travel/presentation/administrator/ui/cubit/administrator_states.dart';
import 'package:travel/presentation/administrator/ui/cubit/administrator_view_model.dart';
import '../../../core/routes/route_names.dart';

class AdminTourScreen extends StatefulWidget {
  const AdminTourScreen({super.key});

  @override
  State<AdminTourScreen> createState() => _AdminTourScreenState();
}

class _AdminTourScreenState extends State<AdminTourScreen> {
  final AdministratorViewModel administratorViewModel =
      getIt<AdministratorViewModel>();

  final OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.blueAccent),
  );

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: _borderStyle,
      enabledBorder: _borderStyle,
      focusedBorder: _borderStyle,
      errorBorder: _borderStyle.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Future<void> _pickImages() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      final permission = sdkInt >= 33 ? Permission.photos : Permission.storage;
      final status = await permission.request();
      if (!status.isGranted) {
        _showSnack('Permission denied');
        return;
      }
    }

    final images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      final remaining = 5 - administratorViewModel.pickedImages.length;
      if (remaining <= 0) {
        _showSnack('You can select up to 5 images only.');
        return;
      }
      administratorViewModel.pickedImages.addAll(
        images.take(remaining).map((x) => File(x.path)),
      );
      setState(() {});
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed:
                    () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.adminScreen,
                      (route) => false,
                    ),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdministratorViewModel, AdministratorStates>(
      bloc: administratorViewModel,
      listener: (context, state) {
        if (state is LoadingState) {
          DialogUtils.showLoading(context: context);
        } else if (state is ErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.errorMessage,
          );
        } else if (state is SuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: "Tour Posted Successfully",
            posActionName: 'Ok',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Add New Tour'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _confirmLogout,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: administratorViewModel.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: administratorViewModel.nameController,
                    decoration: _inputDecoration('Tour Name'),
                    validator:
                        (v) => v == null || v.isEmpty ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: administratorViewModel.descriptionController,
                    maxLines: 3,
                    decoration: _inputDecoration('Description'),
                    validator:
                        (v) =>
                            v == null || v.isEmpty ? 'Enter description' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: administratorViewModel.priceController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Price (EGP)'),
                    validator:
                        (v) => v == null || v.isEmpty ? 'Enter price' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: administratorViewModel.locationController,
                    decoration: _inputDecoration('Location'),
                    validator:
                        (v) => v == null || v.isEmpty ? 'Enter location' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: administratorViewModel.cityController,
                    decoration: _inputDecoration('City'),
                    validator:
                        (v) => v == null || v.isEmpty ? 'Enter city' : null,
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rating (1.0 to 5.0):',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder:
                            (_, __) =>
                                const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate:
                            (value) => administratorViewModel.rating = value,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: administratorViewModel.selectedType,
                    items:
                        administratorViewModel.types
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(
                          () => administratorViewModel.selectedType = value,
                        ),
                    decoration: _inputDecoration('Tour Type'),
                    validator: (v) => v == null ? 'Select a type' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text('Pick Images (2 to 5)'),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        administratorViewModel.pickedImages.map((img) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(img.path),
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: -8,
                                right: -8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed:
                                      () => setState(
                                        () => administratorViewModel
                                            .pickedImages
                                            .remove(img),
                                      ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: administratorViewModel.postTrip,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
