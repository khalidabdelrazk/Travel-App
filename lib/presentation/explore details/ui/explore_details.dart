import 'package:flutter/material.dart';
import 'package:travel/core/model/places.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import '../../../core/theme/color.dart';
import '../../../core/utils/data.dart';
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
  late ExploreResponseEntity data;
  bool toggleFav = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! ExploreResponseEntity) {
      return const Scaffold(body: Center(child: Text("No data provided")));
    }

    data = args;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomImage(
                    data.photos![0],
                    height: height * 0.6,
                    width: width,
                    radius: 10,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextTheme.of(context).headlineMedium,
                          ),
                          Text(
                            data.price?.toString() ?? '',
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
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
                    ],
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
}
