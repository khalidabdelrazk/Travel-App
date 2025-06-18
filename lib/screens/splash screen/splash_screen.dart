import 'package:flutter/material.dart';

import '../../core/routes/route_names.dart';
import '../../core/utils/shared_pref_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          isLoggedIn ? RouteNames.homeScreen : RouteNames.login,
        );
      }
    });
  }

  bool get isLoggedIn => SharedPrefService.instance.getToken() != null;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Travel.png",
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: width * 0.03),
              Image.asset(
                "assets/images/globe icon.png",
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          Text(
            "Find Your Dream",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            "Destination With Us",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
