import 'package:flutter/material.dart';
import 'package:travel/core/di/di.dart';
import 'package:travel/presentation/wishlist/ui/cubit/wishlist_view_model.dart';
import 'package:travel/presentation/wishlist/ui/widgets/wish_trips_card.dart';

import '../../../../core/routes/route_names.dart';
import '../../../trips/domain/Entity/explore_response_entity.dart';

class TripsGrid extends StatelessWidget {
  final List<ExploreResponseEntity> trips;
  final void Function(String id) onFavTap;

  TripsGrid({super.key, required this.trips, required this.onFavTap});

  final WishlistViewModel wishlistViewModel = getIt<WishlistViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          if (constraints.maxWidth > 600) crossAxisCount = 3;
          if (constraints.maxWidth > 900) crossAxisCount = 4;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: trips.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      child: WishTripsCard(
                        trip: trip,
                        onPress: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            RouteNames.exploreDetails,
                            arguments: trip,
                          );

                          if (result == true) {
                            wishlistViewModel.getWishlist();
                          }
                        },
                        onFavTap: () => onFavTap(trip.id!),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
