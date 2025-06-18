import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/presentation/home/ui/cubit/home_states.dart';
import 'package:travel/presentation/home/ui/cubit/home_view_model.dart';
import 'package:travel/presentation/home/ui/widgets/section_with_popular_item.dart';
import '../../../core/common/category_item.dart';
import '../../../core/common/popular_item.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/color.dart';
import '../../../core/utils/data.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final HomeViewModel homeViewModel = getIt<HomeViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.getTrips();
    homeViewModel.getCategoryTrips("beach");
    homeViewModel.getCategoryTrips("mountain");
    homeViewModel.getCategoryTrips("ancient");
    homeViewModel.getCategoryTrips("wonder");
  }

  late double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
            child: Text(
              "Most Popular",
              style: TextTheme.of(context).headlineLarge,
            ),
          ),
          getPopulars(),
          const SizedBox(height: 25),
          getCategory("beach"),
          const SizedBox(height: 25),

          getCategory("mountain"),
          const SizedBox(height: 25),

          getCategory("ancient"),
          const SizedBox(height: 25),

          getCategory("wonder"),
          const SizedBox(height: 77),
        ],
      ),
    );
  }

  getCategories() {
    List<Widget> lists = List.generate(
      categories.length,
      (index) => CategoryItem(
        data: categories[index],
        color: listColors[index % 10],
        onTap: () {},
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget getPopulars() {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: homeViewModel,
      builder: (context, state) {
        if (homeViewModel.mostPopTrips.isEmpty) {
          return SizedBox(
            height: height * 0.4,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ErrorState) {
          return onError(
            errorMessage: state.errorMsg,
            onPressed: homeViewModel.getTrips,
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
              homeViewModel.mostPopTrips.length,
              (index) => SizedBox(
                height: 370,
                child: PopularItem(
                  data: homeViewModel.mostPopTrips[index],
                  onTap: () {},
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getCategory(String queryParams) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: homeViewModel,
      buildWhen: (previous, current) {
        if (current is CategoryLoading || current is CategorySuccess) {
          return (current is CategoryLoading &&
                  current.category == queryParams) ||
              (current is CategorySuccess && current.category == queryParams);
        }
        return false;
      },
      builder: (context, state) {
        if (homeViewModel.categories[queryParams]!.isEmpty) {
          return SizedBox(
            height: height * 0.4,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ErrorState) {
          return onError(
            errorMessage: state.errorMsg,
            onPressed: homeViewModel.getTrips,
          );
        } else {
          return SectionWithPopularItems(
            title: queryParams,
            items: homeViewModel.categories[queryParams] ?? [],
          );
        }
      },
    );
  }

  Widget onError({required String errorMessage, VoidCallback? onPressed}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: onPressed, child: const Text('Try Again')),
        ],
      ),
    );
  }
}
