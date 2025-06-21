import 'package:flutter/material.dart';
import 'package:travel/presentation/home/ui/widgets/category_section.dart';
import 'package:travel/presentation/home/ui/widgets/most_popular_section.dart';
import '../../../core/di/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          const SizedBox(height: 25),
          customText("Most Popular"),
          PopularSection(height: height),
          const SizedBox(height: 25),
          customText("Beach"),
          CategorySection(category: "beach", height: height),
          const SizedBox(height: 25),
          customText("Mountain"),
          CategorySection(category: "mountain", height: height),
          const SizedBox(height: 25),
          customText("Ancient"),
          CategorySection(category: "ancient", height: height),
          const SizedBox(height: 25),
          customText("Wonder"),
          CategorySection(category: "wonder", height: height),
          const SizedBox(height: 77),
        ],
      ),
    );
  }

  customText(String string) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Text(string, style: TextTheme.of(context).headlineMedium),
    );
  }
}
