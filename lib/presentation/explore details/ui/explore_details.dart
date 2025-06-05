import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import '../../../core/theme/color.dart';
import '../../../presentation/common/category_item.dart';
import '../../../presentation/common/custom_image.dart';

class ExploreDetails extends StatefulWidget {
  const ExploreDetails({super.key});

  @override
  State<ExploreDetails> createState() => _ExploreDetailsState();
}

class _ExploreDetailsState extends State<ExploreDetails> {
  late double width;
  late double height;
  late List tripInfo;
  late ExploreResponseEntity data;
  bool toggleFav = false;

  int currentImageIndex = 0;
  late PageController pageController;
  late Timer autoScrollTimer;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    startAutoScroll();
  }

  void startAutoScroll() {
    autoScrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (!mounted || data.photos == null || data.photos!.isEmpty) return;
      final nextPage = (currentImageIndex + 1) % data.photos!.length;
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    autoScrollTimer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! ExploreResponseEntity) {
      return const Scaffold(body: Center(child: Text("No data provided")));
    }

    data = args;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    tripInfo = [
      {
        "icon": Icons.star_rate_rounded,
        "value": (data.rating ?? 0).toString(),
      },
      {
        "icon": Icons.wb_sunny_rounded,
        "value": "${getRandomNumberByTime()}°C",
      },
      {
        "icon": Icons.attach_money_rounded,
        "value": '${data.price}',
      },
    ];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  imageSlider(),
                  SizedBox(height: height * 0.02),
                  detailsBar(),
                  SizedBox(height: height * 0.02),
                  placeInfo(),
                  SizedBox(height: height * 0.02),
                  Text(
                    'Description',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  Text(
                    data.description ?? '',
                    style: TextTheme.of(context).bodyMedium,
                  ),
                  SizedBox(height: height * 0.02),
                  ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 5,
                      ),
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                    child: Text("Book Now"),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ],
        ),
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
                data.name ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                children: [
                  Icon(Icons.location_on, size: 15),
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
        IconButton(
          onPressed: () {
            toggleFav = !toggleFav;
            setState(() {});
          },
          icon: Icon(
            toggleFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ],
    );
  }



  Widget placeInfo() {
    int index = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            tripInfo.map((info) {
              return CategoryItem(data: info, color: listColors[index++ % 10]);
            }).toList(),
      ),
    );
  }

  Widget imageSlider() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: height * 0.6,
              width: width,
              child: PageView.builder(
                controller: pageController,
                itemCount: data.photos?.length ?? 0,
                onPageChanged: (index) {
                  setState(() {
                    currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomImage(
                      data.photos![index],
                      height: height * 0.6,
                      width: width,
                      radius: 10,
                    ),
                  );
                },
              ),
            ),
            // Left button
            Positioned(
              left: 10,
              top: height * 0.3 - 25,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                onPressed: () {
                  final previous =
                      (currentImageIndex - 1 + data.photos!.length) %
                      data.photos!.length;
                  pageController.animateToPage(
                    previous,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            // Right button
            Positioned(
              right: 10,
              top: height * 0.3 - 25,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  final next = (currentImageIndex + 1) % data.photos!.length;
                  pageController.animateToPage(
                    next,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(data.photos!.length, (index) {
            bool isActive = index == currentImageIndex;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  int getRandomNumberByTime() {
    final now = DateTime.now();
    final seed = now.millisecondsSinceEpoch; // You can also use second/minute
    final random = Random(seed);
    return 20 + random.nextInt(11); // 20 to 30 inclusive
  }
}
