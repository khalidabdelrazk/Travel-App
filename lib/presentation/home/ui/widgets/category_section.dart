import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/di/di.dart';
import 'package:travel/presentation/home/ui/cubit/category/category_states.dart';
import 'package:travel/presentation/home/ui/cubit/category/category_view_model.dart';
import 'package:travel/presentation/home/ui/widgets/section_with_popular_item.dart';
import '../cubit/most popular/most_popular_states.dart';

class CategorySection extends StatefulWidget {
  final String category;
  final double height;

  const CategorySection({
    super.key,
    required this.category,
    required this.height,
  });

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final CategoryViewModel categoryViewModel = getIt<CategoryViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryViewModel.getCategoryTrips(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryViewModel, CategoryStates>(
      bloc: categoryViewModel,
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryErrorState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMsg, textAlign: TextAlign.center),
              TextButton(
                onPressed:
                    () => categoryViewModel.getCategoryTrips(widget.category),
                child: Text('Try Again'),
              ),
            ],
          );
        } else {
          return SectionWithPopularItems(
            title: widget.category,
            items: categoryViewModel.categories[widget.category] ?? [],
          );
        }
      },
    );
  }
}
