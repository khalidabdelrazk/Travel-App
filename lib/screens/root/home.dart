import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/model/places.dart';
import '../../theme/color.dart';
import '../../utils/data.dart';
import '../../widgets/category_item.dart';
import '../../widgets/notification_box.dart';
import '../../widgets/popular_item.dart';

class HomePage extends StatefulWidget {
  final Function(bool, int) onTap;
  final Function(Place) objectPressed;
  const HomePage({super.key, required this.onTap, required this.objectPressed});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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

  Widget getAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, user",
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "Let's Explore",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        NotificationBox(notifiedNumber: 1, onTap: () {}),
      ],
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

  getPopulars() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 370,
        enlargeCenterPage: true,
        disableCenter: true,
        viewportFraction: .75,
      ),
      items: List.generate(
        populars.length,
        (index) => GestureDetector(
          onTap: () {
            widget.onTap(false, 3);
            widget.objectPressed(places[index]);
            // Navigator.pushNamed(context, RouteNames.tripDetails,arguments: populars[index]);
          },
          child: PopularItem(data: places[index], onTap: () {}),
        ),
      ),
    );
  }
}
