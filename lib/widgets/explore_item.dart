import 'package:flutter/material.dart';
import 'custom_image.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({ super.key, required this.data, this.onTap, this.radius = 10 });
  final dynamic data;
  final double radius;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius)
      ),
      child: Stack(
        children: [
          CustomImage(data["image"],
            radius: radius, width: double.infinity, height: double.infinity,
          ),
          Container(
            width: double.infinity, height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(.5),
                  Colors.white.withOpacity(.01),
                ]
              )
            ),
          ),
          Positioned(
            bottom: 12, left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data["name"], style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}