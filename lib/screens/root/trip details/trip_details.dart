import 'package:flutter/material.dart';
import 'package:travel/core/model/places.dart';
import 'package:travel/widgets/category_item.dart';
import 'package:travel/widgets/custom_image.dart';

import '../../../theme/color.dart';
import '../../../utils/data.dart';

class TripDetails extends StatefulWidget {
  final Place place;
  const TripDetails({super.key, required this.place});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late double width;
  late double height;
  bool toggleFav = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomImage(
                  widget.place.image,
                  height: height * 0.6,
                  width: width,
                  radius: 10,
                ),
                SizedBox(height: height * 0.02),
                detailsBar(),
                SizedBox(height: height * 0.02),
                placeInfo(),
                SizedBox(height: height * 0.02),
                Text('Description',style: TextTheme.of(context).headlineMedium,),
                Text(
                  widget.place.description,
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
                        Text('\$500/Person', style: TextTheme.of(context).bodyMedium),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => showSuccessDialog(context),

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                      child: Text("Book Now",),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.place.name,
              style: TextTheme.of(context).headlineMedium,
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 15),
                Text(
                  widget.place.location,
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),
          ],
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismiss by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Submission Successful"),
          content: const Text("Thank you! Someone will reach out to you within 2 days for more information."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

}
