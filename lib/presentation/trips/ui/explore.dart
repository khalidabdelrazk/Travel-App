import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel/core/di/di.dart';
import 'package:travel/presentation/common/custom_text_field.dart';
import 'package:travel/presentation/trips/ui/cubit/explore_states.dart';
import 'package:travel/presentation/trips/ui/cubit/explore_view_model.dart';
import '../../../core/routes/route_names.dart';
import '../../common/explore_item.dart';
import 'dart:async';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late final ExploreViewModel exploreViewModel = getIt<ExploreViewModel>();
  late TabController _tabController;
  Timer? _debounce; // Debounce timer
  String _lastQuery = ''; // Stores the last fetched query for the current tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Add listener for tab changes
    _tabController.addListener(_onTabChanged);

    searchController.addListener(_onSearchChanged);
    _fetchData(); // Initial fetch when the page loads
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _tabController.removeListener(_onTabChanged); // Remove tab listener
    _tabController.dispose();
    _debounce?.cancel(); // Cancel the debounce timer
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final currentQuery = searchController.text.trim();
      // Only fetch if the query has changed AND is different from the last fetched query
      // This prevents refetching if user types and deletes back to the same last query
      if (currentQuery != _lastQuery) {
        _lastQuery = currentQuery; // Update last query before fetching
        _fetchData();
      }
    });
  }

  void _onTabChanged() {
    // Only fetch data if the tab is not being animated (i.e., it's settled)
    if (!_tabController.indexIsChanging) {
      _lastQuery = ''; // Reset _lastQuery when tab changes
      // Immediately fetch data for the newly selected tab using the current search query
      _fetchData();
    }
  }


  void _fetchData() {
    final query = searchController.text.trim();
    if (_tabController.index == 0) {
      exploreViewModel.getTrips(query);
    } else {
      exploreViewModel.getHotels(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextField(
                label: 'Search by City',
                controller: searchController,
                prefixIcon: Icons.search,
                suffixIcon: Icons.clear,
                onSuffixPressed: () {
                  searchController.clear();
                  _lastQuery = ''; // Clear the last query when the search box is cleared
                  FocusManager.instance.primaryFocus?.unfocus();
                  _fetchData(); // Fetch data immediately after clearing
                },
              ),
            ),
            const SizedBox(height: 15),
            _buildTabBar(),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPlacesView(tabIndex: 0),
                  _buildPlacesView(tabIndex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabAlignment: TabAlignment.start,
      // No onTap needed here, as the listener handles it
      indicatorSize: TabBarIndicatorSize.tab,
      isScrollable: true,
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

  Widget _buildPlacesView({required int tabIndex}) {
    return BlocBuilder<ExploreViewModel, ExploreStates>(
      bloc: exploreViewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errorMessage, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _fetchData,
                  child: const Text('Try Again'),
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
              itemBuilder: (context, index) {
                final data = state.response[index];
                return ExploreItem(
                  data: data,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.exploreDetails,
                      arguments: data,
                    );
                  },
                );
              },
              staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
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