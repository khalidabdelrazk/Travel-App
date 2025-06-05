import 'package:flutter/material.dart';
import 'package:travel/core/utils/data.dart';
import '../../core/model/places.dart';
import '../../core/theme/color.dart';
import '../../core/utils/constant.dart';
import '../../presentation/explore details/ui/explore_details.dart';
import '../../presentation/trips/ui/explore.dart';
import '../../presentation/common/bottombar_item.dart';
import '../../presentation/common/drawer.dart';
import 'home.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  RootAppState createState() => RootAppState();
}

class RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int activeTab = 1;
  bool showFloatingActionButton = true;
  Place popular = places[0];

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: animatedBodyMs),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get barItems => [
    {
      "icon": "assets/icons/navigation.svg",
      "active_icon": "assets/icons/navigation.svg",
      "page": ExplorePage(),
      "title": "Explore",
    },
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": HomePage(
        onTap: (p0, myIndex) => onTap(p0, myIndex),
        objectPressed: (p0) => setPopular(p0),
      ),
      "title": "Home",
    },
    {
      "icon": "assets/icons/settings.svg",
      "active_icon": "assets/icons/settings.svg",
      "page": Container(),
      "title": "Test",
    },
    {
      "icon": "assets/icons/settings.svg",
      "active_icon": "assets/icons/settings.svg",
      "page": ExploreDetails(),
      "title": popular.name,
    },
  ];

  void onPageChanged(int index) async{
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
            );
          },
        ),
        title: Text(
          barItems[activeTab]["title"],
          style: TextTheme.of(context).headlineMedium,
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(onTap: (p0, p1) => onTap(p0, p1)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: getBarPage(),
      floatingActionButton: !showFloatingActionButton ? null : getBottomBar(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBarPage() {
    return IndexedStack(
      index: activeTab,
      children: List.generate(
        barItems.length,
            (index) => FadeTransition(
          child: barItems[index]["page"],
          opacity: _animation,
        ),
      ),
    );
  }

  Widget getBottomBar() {
    return Container(
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withAlpha(25),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          2,
              (index) => BottomBarItem(
            activeTab == index
                ? barItems[index]["active_icon"]
                : barItems[index]["icon"],
            "",
            isActive: activeTab == index,
            activeColor: Theme.of(context).primaryColor,
            onTap: () {
              onPageChanged(index);
            },
          ),
        ),
      ),
    );
  }

  void onTap(bool value, int index) {
    setState(() {
      showFloatingActionButton = value;
      activeTab = index;
    });
  }

  void setPopular(Place val) {
    setState(() {
      popular = val;
    });
  }
}
