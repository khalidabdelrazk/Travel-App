// explore_details_body.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/presentation/explore%20details/ui/widgets/book_now.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_view_model.dart';

import '../../../../core/common/category_item.dart';
import '../../../../core/theme/color.dart';
import 'image_slider.dart';

class ExploreDetailsBody extends StatefulWidget {
  final BuildContext context;
  final ExploreResponseEntity data;
  final double width;
  final double height;
  final List tripInfo;
  final TripDetailsViewModel viewModel;
  final PageController pageController;
  final int currentImageIndex;
  final Function(int) onImageIndexChanged;

  const ExploreDetailsBody({
    super.key,
    required this.context,
    required this.data,
    required this.width,
    required this.height,
    required this.tripInfo,
    required this.viewModel,
    required this.pageController,
    required this.currentImageIndex,
    required this.onImageIndexChanged,
  });

  @override
  State<ExploreDetailsBody> createState() => _ExploreDetailsBodyState();
}

class _ExploreDetailsBodyState extends State<ExploreDetailsBody> {
  Timer? autoScrollTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && widget.pageController.hasClients) {
        startAutoScroll();
      }
    });
  }

  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || widget.data.photos == null || widget.data.photos!.isEmpty)
        return;
      final nextPage =
          (widget.currentImageIndex + 1) % widget.data.photos!.length;
      widget.pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    autoScrollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              children: [
                ImageSlider(
                  photos: widget.data.photos!,
                  width: widget.width,
                  height: widget.height,
                  controller: widget.pageController,
                  currentIndex: widget.currentImageIndex,
                  onIndexChanged: widget.onImageIndexChanged,
                ),
                SizedBox(height: widget.height * 0.02),
                detailsBar(),
                SizedBox(height: widget.height * 0.02),
                placeInfo(),
                SizedBox(height: widget.height * 0.02),
                Text(
                  'Description',
                  style: TextTheme.of(context).headlineMedium,
                ),
                Text(
                  widget.data.description ?? '',
                  style: TextTheme.of(context).bodyMedium,
                ),
                // SizedBox(height: widget.height * 0.02),
                SizedBox(height: 70,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.name ?? '',
                style: Theme.of(widget.context).textTheme.headlineMedium,
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 15),
                  Flexible(
                    child: Text(
                      widget.data.location ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(widget.context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<TripDetailsViewModel, dynamic>(
          bloc: widget.viewModel,
          builder: (context, state) {
            bool isFav = widget.viewModel.toggleFav;
            return IconButton(
              onPressed: () {
                widget.viewModel.toggleFav = !isFav;
                widget.viewModel.addToFav(
                  widget.data.id ?? '',
                  widget.viewModel.toggleFav,
                );
              },
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget placeInfo() {
    int index = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            widget.tripInfo
                .map(
                  (info) =>
                      CategoryItem(data: info, color: listColors[index++ % 10]),
                )
                .toList(),
      ),
    );
  }
}
