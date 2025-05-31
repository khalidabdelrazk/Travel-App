import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/color.dart';
import '../../utils/data.dart';
import '../../widgets/explore_category_item.dart';
import '../../widgets/explore_item.dart';
import '../../widgets/icon_box.dart';
import '../../widgets/round_textbox.dart';

class ExplorePage extends StatefulWidget {
  final Function(bool) onScroll;
  const ExplorePage({super.key, required this.onScroll});

  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage> {
  final ScrollController listViewController = ScrollController();
  int selectedIndex = 0;
  static const int threshold = 40;
  ScrollDirection? _lastDirection;

  @override
  void initState() {
    super.initState();
    listViewController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final direction = listViewController.position.userScrollDirection;
    if (_lastDirection != direction) {
      _lastDirection = direction;
      widget.onScroll(direction == ScrollDirection.forward); // show/hide FAB
    }
  }

  @override
  void dispose() {
    listViewController.removeListener(_scrollListener);
    listViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        controller: listViewController,
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RoundTextBox(
              hintText: "Search",
              prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 20),
          getCategories(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: getPlaces(),
          ),
        ],
      ),
    );
  }

  Widget getAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconBox(
          child: SvgPicture.asset(
            "assets/icons/filter.svg",
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }

  Widget getCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(
        children: List.generate(
          exploreCategories.length,
              (index) => ExploreCategoryItem(
            data: exploreCategories[index],
            selected: index == selectedIndex,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget getPlaces() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: countries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ExploreItem(
          data: countries[index],
          onTap: () {
            // Handle tap
          },
        );
      },
    );
  }
}
