import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/utils/shared_pref_services.dart';
import 'package:travel/presentation/home/ui/cubit/home_states.dart';
import 'package:travel/presentation/home/ui/cubit/home_view_model.dart';

import '../../../core/di/di.dart';
import '../../../core/theme/color.dart';
import '../../../core/utils/data.dart';
import '../../common/category_item.dart';
import '../../common/notification_box.dart';
import '../../common/popular_item.dart';

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
  }

  late double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   backgroundColor: appBarColor,
          //   pinned: true,
          //   snap: true,
          //   floating: true,
          //   title: getAppBar(),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => buildBody(),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }


  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: getCategories(),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
              child: Text(
                "Most Popular",
                style: TextTheme.of(context).headlineLarge,
              ),
            ),
            getPopulars(),
            SizedBox(height: 25),
          ],
        ),
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
    return BlocBuilder(
      bloc: homeViewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return SizedBox(
            height: height*0.4, // Matches the height of the CarouselSlider
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => homeViewModel.getTrips(),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is SuccessState) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 370,
              enlargeCenterPage: true,
              disableCenter: true,
              viewportFraction: .75,
            ),
            items: List.generate(
              state.response.length,
              (index) => GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.tripDetails,arguments: populars[index]);
                },
                child: PopularItem(data: state.response[index], onTap: () {}),
              ),
            ),
          );
        }
        return Container(color: Colors.red, width: 40, height: 40);
      },
    );
  }
}
