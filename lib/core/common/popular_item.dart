import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel/presentation/home/domain/Entity/trips_response_entity.dart';
import 'custom_image.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({
    super.key,
    required this.data,
    this.onTap,
    this.radius = 20,
    this.width = 200,
    this.height = 350,
  });
  final HomeTripsResponseEntity data;
  final double radius;
  final GestureTapCallback? onTap;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 1, color: Theme.of(context).cardColor),
        ),
        child: Stack(
          children: [
            CustomImage(
              data.photos![1],
              radius: radius,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(.5),
                    Colors.white.withOpacity(.01),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name??"",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/marker.svg",
                        width: 15,
                        height: 15,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          data.location??"",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
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
