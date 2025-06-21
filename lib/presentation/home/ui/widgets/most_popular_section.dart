import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel/core/di/di.dart';
import 'package:travel/presentation/home/ui/cubit/most%20popular/most_popular_view_model.dart';
import '../../../../core/common/popular_item.dart';
import '../../../../core/routes/route_names.dart';
import '../cubit/most popular/most_popular_states.dart';

class PopularSection extends StatefulWidget {
  final double height;

  const PopularSection({super.key, required this.height});

  @override
  State<PopularSection> createState() => _PopularSectionState();
}

class _PopularSectionState extends State<PopularSection> {
  final MostPopularViewModel mostPopularViewModel =
      getIt<MostPopularViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostPopularViewModel.getTrips();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostPopularViewModel, MostPopularStates>(
      bloc: mostPopularViewModel,
      builder: (context, state) {
        if (state is MostPopularLoading) {
          return const SizedBox(
            height: 370,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is MostPopularErrorState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMsg, textAlign: TextAlign.center),
              TextButton(
                onPressed: mostPopularViewModel.getTrips,
                child: Text('Try Again'),
              ),
            ],
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              height: 370,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: .75,
            ),
            items: List.generate(
              mostPopularViewModel.mostPopTrips.length,
              (index) => SizedBox(
                height: 370,
                child: PopularItem(
                  data: mostPopularViewModel.mostPopTrips[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.exploreDetails,
                      arguments: mostPopularViewModel.mostPopTrips[index],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
