import 'package:flutter/cupertino.dart';
import 'package:travel/core/routes/route_names.dart';
import 'package:travel/presentation/chatbot/ui/chatbot.dart';
import '../../presentation/explore details/ui/explore_details.dart';
import '../../screens/root/root.dart';
import '../../screens/splash screen/splash_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.splash: (_) => SplashScreen(),
    RouteNames.homeScreen: (_) => RootApp(),
    RouteNames.exploreDetails: (_) => ExploreDetails(),
    RouteNames.chatBot: (_) => Chatbot(),
  };
}
