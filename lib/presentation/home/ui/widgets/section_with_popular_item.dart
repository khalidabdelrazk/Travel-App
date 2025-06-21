import 'package:flutter/material.dart';

import '../../../../core/common/popular_item.dart';
import '../../../../core/routes/route_names.dart';
import '../../domain/Entity/trips_response_entity.dart';

class SectionWithPopularItems extends StatelessWidget {
  final String title;
  final List<HomeTripsResponseEntity> items;

  const SectionWithPopularItems({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horizontal List of Popular Items
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return PopularItem(
                data: items[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.exploreDetails,
                    arguments: items[index],
                  );
                },
                height: 220,
                width: 200,
              );
            },
          ),
        ),

        // SizedBox(height: 77),
      ],
    );
  }
}
