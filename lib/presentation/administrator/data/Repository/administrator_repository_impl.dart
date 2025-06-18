import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/presentation/administrator/domain/Entity/administrator_response_entity.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/Repository/administrator_repository.dart';
import '../Data Sources/administrator_remote_data_source.dart';

@Injectable(as: AdministratorRepository)
class AdministratorRepositoryImpl extends AdministratorRepository {
  final AdministratorRemoteDataSource administratorRemoteDataSource;
  AdministratorRepositoryImpl(this.administratorRemoteDataSource);

  @override
  Future<Either<Failures, TourResponseEntity>> postTour({
    required String name,
    required String description,
    required String price,
    required String location,
    required String city,
    required String type,
    required double rating,
    required List<File> photos,
  }) async {
    var either = await administratorRemoteDataSource.postTour(
      name: name,
      description: description,
      price: price,
      location: location,
      city: city,
      type: type,
      rating: rating,
      photos: photos,
    );
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
