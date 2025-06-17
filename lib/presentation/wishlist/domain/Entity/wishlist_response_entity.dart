import 'package:travel/presentation/trips/domain/Entity/trips_response_entity.dart';

class WishlistResponseEntity extends TripsResponseEntity {
  WishlistResponseEntity({
    super.id,
    super.name,
    super.description,
    super.photos,
    super.price,
    super.location,
    super.city,
    super.createdAt,
    super.updatedAt,
    super.rating,
  });
}
