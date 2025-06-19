import 'package:flutter/cupertino.dart';
import 'package:travel/core/routes/route_names.dart';
import 'package:travel/presentation/authentication/ui/screens/login.dart';
import 'package:travel/presentation/authentication/ui/screens/register.dart';
import 'package:travel/presentation/chatbot/ui/chatbot.dart';
import 'package:travel/presentation/onboarding/ui/onboarding_screen.dart';
import '../../presentation/administrator/ui/admin_tour_screen.dart';
import '../../presentation/authentication/ui/screens/reset_password.dart';
import '../../presentation/explore details/ui/explore_details.dart';
import '../../presentation/root/root.dart';
import '../../presentation/splash screen/splash_screen.dart';


class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.splash: (_) => SplashScreen(),
    RouteNames.homeScreen: (_) => RootApp(),
    RouteNames.exploreDetails: (_) => ExploreDetails(),
    RouteNames.chatBot: (_) => Chatbot(),
    RouteNames.login: (_) => Login(),
    RouteNames.register: (_) => Register(),
    RouteNames.forgetPassword: (_) => ResetPassword(),
    RouteNames.adminScreen: (_) => AdminTourScreen(),
    RouteNames.onBoarding: (_) => OnboardingScreen(),
  };
}
