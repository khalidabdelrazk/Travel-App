import 'package:flutter/material.dart';
import 'package:travel/presentation/trips/ui/widget/places.dart';
import '../../common/round_textbox.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RoundTextBox(
                hintText: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            _buildTabBar(context),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  GetPlaces(tabIndex: 0), // Trips
                  GetPlaces(tabIndex: 1), // Hotels
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      padding: EdgeInsets.zero,
      indicatorColor: Theme.of(context).primaryColor,
      labelColor: Theme.of(context).primaryColor,
      unselectedLabelColor: Theme.of(context).primaryColor.withAlpha(150),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      tabs: const [
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trip_origin, size: 20),
              SizedBox(width: 8),
              Text('Trips'),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hotel_sharp, size: 20),
              SizedBox(width: 8),
              Text('Hotels'),
            ],
          ),
        ),
      ],
    );
  }
}
