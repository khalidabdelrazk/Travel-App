import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/core/common/network_error_widget.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_states.dart';
import 'package:travel/presentation/explore%20details/ui/cubit/trip_details_view_model.dart';
import 'package:travel/presentation/explore%20details/ui/widgets/book_now.dart';
import 'package:travel/presentation/explore%20details/ui/widgets/explore_details_body.dart';
import 'package:travel/presentation/trips/domain/Entity/explore_response_entity.dart';
import 'package:travel/core/common/dialog_utils.dart';
import 'package:travel/core/di/di.dart';

import 'cubit/book_view_model.dart';

class ExploreDetails extends StatefulWidget {
  const ExploreDetails({super.key});

  @override
  State<ExploreDetails> createState() => _ExploreDetailsState();
}

class _ExploreDetailsState extends State<ExploreDetails> {
  late final TripDetailsViewModel tripDetailsViewModel =
  getIt<TripDetailsViewModel>();
  late double width;
  late double height;
  late List tripInfo;
  late ExploreResponseEntity? data;

  int currentImageIndex = 0;
  late PageController pageController;

  late int temperature;
  bool isScreenLoading = true;
  bool isRetrying = false;

  DetailsErrorState? detailsErrorState;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is ExploreResponseEntity) {
      data = args;
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;

      temperature = getRandomNumberByTime();

      tripInfo = [
        {"icon": Icons.star_rate_rounded, "value": (data?.rating ?? 0).toString()},
        {"icon": Icons.wb_sunny_rounded, "value": "$temperature°C"},
        {
          "icon": Icons.attach_money_rounded,
          "value": '${data?.price}${data?.type == 'hotel' ? '/Day' : '/Person'}',
        },
      ];

      tripDetailsViewModel.isTripFav(data!.id ?? '').then((isFav) {
        if (mounted) {
          setState(() {
            tripDetailsViewModel.toggleFav = isFav;
            isScreenLoading = false;
          });
        }
      });
    } else {
      Future.microtask(() {
        if (mounted) {
          setState(() {
            isScreenLoading = false;
            data = null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: BlocListener<TripDetailsViewModel, TripDetailsStates>(
        bloc: tripDetailsViewModel,
        listener: (context, state) {
          if (state is DetailsSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.response.message ?? "Success")),
            );
          } else if (state is DetailsErrorState) {
            setState(() {
              tripDetailsViewModel.toggleFav = !tripDetailsViewModel.toggleFav;
              detailsErrorState = state;
            });
          }
        },
        child: isScreenLoading
            ? const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        )
            : data == null
            ? const Scaffold(body: Center(child: Text("No data provided")))
            : detailsErrorState != null
            ? Scaffold(
          body: isRetrying
              ? const Center(child: CircularProgressIndicator())
              : NetworkErrorWidget(
            errorMsg: detailsErrorState!.errorMessage,
            large: true,
            onTap: () async {
              setState(() {
                isRetrying = true;
              });

              await tripDetailsViewModel.isTripFav(data?.id ?? "");

              if (mounted) {
                setState(() {
                  detailsErrorState = null;
                  isRetrying = false;
                });
              }
            },
          ),
        )
            : Scaffold(
          appBar: AppBar(
            surfaceTintColor: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
            elevation: 6,
            centerTitle: true,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            title: Text(
              data?.name ?? "",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextTheme.of(context).bodySmall,
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocProvider<BookNowViewModel>(
            create: (_) => getIt<BookNowViewModel>(),
            child: BookNow(
              tripId: data?.id ?? " ",
              type: data?.type ?? 'hotel',
            ),
          ),
          body: ExploreDetailsBody(
            context: context,
            data: data!,
            width: width,
            height: height,
            tripInfo: tripInfo,
            viewModel: tripDetailsViewModel,
            pageController: pageController,
            currentImageIndex: currentImageIndex,
            onImageIndexChanged: (index) {
              setState(() => currentImageIndex = index);
            },
          ),
        ),
      ),
    );
  }

  int getRandomNumberByTime() {
    final now = DateTime.now();
    final seed = now.millisecondsSinceEpoch;
    final random = Random(seed);
    return 20 + random.nextInt(11);
  }
}
