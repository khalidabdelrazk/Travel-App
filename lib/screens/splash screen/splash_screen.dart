import 'package:flutter/material.dart';

import '../../core/routes/route_names.dart';

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
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Travel.png"),
              SizedBox(width: width*0.03,),
              Image.asset("assets/images/globe icon.png")
            ],
          ),
          SizedBox(height: height*0.04,),
          Text("Find Your Dream",style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),),
          Text("Destination With Us",style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),)
        ],
      ),
    );
  }
}
