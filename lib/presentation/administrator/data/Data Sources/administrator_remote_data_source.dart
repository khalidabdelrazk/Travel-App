import 'dart:io';

import 'package:either_dart/either.dart';
import '../../../../../core/error/failures.dart';
import '../Models/tour_response_dm.dart';

abstract class AdministratorRemoteDataSource {
  Future<Either<Failures, TourResponseDm>> postTour(
      {
        required String name,
        required String description,
        required String price,
        required String location,
        required String city,
        required String type,
        required double rating,
        required List<File> photos,
      }
  );
}
