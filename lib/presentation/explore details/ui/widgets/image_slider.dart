// image_slider.dart
import 'package:flutter/material.dart';

import '../../../../core/common/custom_image.dart';

class ImageSlider extends StatelessWidget {
  final List<String> photos;
  final double width;
  final double height;
  final PageController controller;
  final int currentIndex;
  final Function(int) onIndexChanged;

  const ImageSlider({
    super.key,
    required this.photos,
    required this.width,
    required this.height,
    required this.controller,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: height * 0.6,
              width: width,
              child: PageView.builder(
                controller: controller,
                itemCount: photos.length,
                onPageChanged: onIndexChanged,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomImage(photos[index], height: height * 0.6, width: width, radius: 10),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: height * 0.3 - 25,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                onPressed: () {
                  final previous = (currentIndex - 1 + photos.length) % photos.length;
                  controller.animateToPage(previous, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                },
              ),
            ),
            Positioned(
              right: 10,
              top: height * 0.3 - 25,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 28),
                onPressed: () {
                  final next = (currentIndex + 1) % photos.length;
                  controller.animateToPage(next, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(photos.length, (index) {
            bool isActive = index == currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
