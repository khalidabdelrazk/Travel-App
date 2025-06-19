// explore_details_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_view_model.dart';

import '../../../../core/common/category_item.dart';
import '../../../../core/theme/color.dart';
import 'image_slider.dart';


class ExploreDetailsBody extends StatelessWidget {
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
                  photos: data.photos!,
                  width: width,
                  height: height,
                  controller: pageController,
                  currentIndex: currentImageIndex,
                  onIndexChanged: onImageIndexChanged,
                ),
                SizedBox(height: height * 0.02),
                detailsBar(),
                SizedBox(height: height * 0.02),
                placeInfo(),
                SizedBox(height: height * 0.02),
                Text('Description', style: TextTheme.of(context).headlineMedium),
                Text(data.description ?? '', style: TextTheme.of(context).bodyMedium),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                  child: const Text("Book Now"),
                ),
                SizedBox(height: height * 0.02),
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
              Text(data.name ?? '', style: Theme.of(context).textTheme.headlineMedium),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 15),
                  Flexible(
                    child: Text(
                      data.location ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<TripDetailsViewModel, dynamic>(
          bloc: viewModel,
          builder: (context, state) {
            bool isFav = viewModel.toggleFav;
            return IconButton(
              onPressed: () {
                viewModel.toggleFav = !isFav;
                viewModel.addToFav(data.id ?? '', viewModel.toggleFav);
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
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
        children: tripInfo
            .map((info) => CategoryItem(data: info, color: listColors[index++ % 10]))
            .toList(),
      ),
    );
  }
}
