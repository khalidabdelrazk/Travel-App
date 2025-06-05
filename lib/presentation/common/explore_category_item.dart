import 'package:flutter/material.dart';
import '../../core/theme/color.dart';

class ExploreCategoryItem extends StatelessWidget {
  const ExploreCategoryItem({
    super.key,
    required this.data,
    this.bgColor = Colors.white,
    this.color = primaryLight,
    this.selected = false,
    this.onTap,
  });
  final dynamic data;
  final Color bgColor;
  final Color color;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 70,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              data,
              maxLines: 1,
              style: TextTheme.of(context).bodyMedium!.copyWith(
                color:
                    selected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withAlpha(150),
              ),
            ),
            Visibility(
              visible: selected,
              child: Container(
                // margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 2,
                decoration: BoxDecoration(color: secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
