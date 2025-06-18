import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../Entity/administrator_response_entity.dart';
import '../Repository/administrator_repository.dart';

@Injectable()
class AdministratorUseCase {
  final AdministratorRepository administratorRepository;
  AdministratorUseCase({required this.administratorRepository});
  Future<Either<Failures, TourResponseEntity>> invoke({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  }) {
    return administratorRepository.postTour(
      name: name,
      description: description,
      price: price,
      location: location,
      city: city,
      type: type,
      rating: rating,
      photos: photos,
    );
  }
}
