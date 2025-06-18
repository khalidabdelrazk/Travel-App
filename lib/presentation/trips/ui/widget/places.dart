import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../core/common/explore_item.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/route_names.dart';
import '../cubit/explore_states.dart';
import '../cubit/explore_view_model.dart';

class GetPlaces extends StatefulWidget {
  final int tabIndex;
  final TextEditingController controller;
  const GetPlaces({super.key, required this.tabIndex, required this.controller});

  @override
  State<GetPlaces> createState() => _GetPlacesState();
}

class _GetPlacesState extends State<GetPlaces> {
  late ExploreViewModel exploreViewModel = getIt<ExploreViewModel>();
  bool initialized = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!initialized) {
      if (widget.tabIndex == 0) {
        exploreViewModel.getTrips(widget.controller.text);
      } else if (widget.tabIndex == 1) {
        exploreViewModel.getHotels(widget.controller.text);
      }
      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: exploreViewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage,
                  style: TextTheme.of(context).labelLarge,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (widget.tabIndex == 0) {
                      exploreViewModel.getTrips('controllerText');
                    } else if (widget.tabIndex == 1) {
                      exploreViewModel.getHotels('controllerText');
                    }
                  },
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is SuccessState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: state.response.length,
              itemBuilder:
                  (BuildContext context, int index) => ExploreItem(
                    data: state.response[index],
                    onTap: () {
                      // handle tap
                      Navigator.pushNamed(
                        context,
                        RouteNames.exploreDetails,
                        arguments: state.response[index],
                      );
                    },
                  ),
              staggeredTileBuilder:
                  (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.only(top: 8, bottom: 70),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
