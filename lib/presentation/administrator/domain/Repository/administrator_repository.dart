import 'dart:io';

import 'package:either_dart/either.dart';
import '../../../../../../core/error/failures.dart';
import '../Entity/administrator_response_entity.dart';

abstract class AdministratorRepository {
  Future<Either<Failures, TourResponseEntity>> postTour({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  });
}
