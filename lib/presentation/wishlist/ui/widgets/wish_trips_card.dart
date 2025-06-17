import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel/presentation/common/custom_image.dart';
import 'package:travel/presentation/trips/domain/Entity/trips_response_entity.dart';

class WishTripsCard extends StatelessWidget {
  const WishTripsCard({
    super.key,
    required this.trip,
    required this.onPress,
    required this.onFavTap,
  });

  final TripsResponseEntity trip;
  final VoidCallback onPress;
  final VoidCallback onFavTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double cardWidth = screenWidth / 2.3;
    if (screenWidth > 600) cardWidth = screenWidth / 3.2;
    if (screenWidth > 900) cardWidth = screenWidth / 4.2;

    return SizedBox(
      width: cardWidth,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.9,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withAlpha(200),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: CustomImage(trip.photos?[1] ?? "", radius: 0),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.name ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${trip.price ?? ""}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF7643),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          onFavTap.call();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7643).withAlpha(200),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/icons/heart.svg"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
