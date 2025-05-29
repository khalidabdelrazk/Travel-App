import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel/core/model/places.dart';
import 'package:travel/utils/constant.dart';

import 'custom_image.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({
    super.key,
    required this.data,
    this.onTap,
    this.radius = 20,
  });
  final Place data;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: Theme.of(context).cardColor),
      ),
      child: Stack(
        children: [
          CustomImage(
            data.image,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
                    Text(
                      data.location,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
