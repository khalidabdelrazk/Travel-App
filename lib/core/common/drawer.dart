import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel/core/provider/theme_provider.dart';
import 'package:travel/core/routes/route_names.dart';
import 'package:travel/core/utils/shared_pref_services.dart';
import '../../core/theme/color.dart';
import 'custom_button.dart';

class MyDrawer extends StatefulWidget {
  final Function(bool, int) onTap;
  const MyDrawer({super.key, required this.onTap});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late ThemeProvider themeProvider;
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    selectedTheme = themeProvider.isDark ? 'Dark' : 'Light';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Drawer(
      width: width * 0.75,
      child: Column(
        children: [
          SizedBox(height: height * 0.05),
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
          Text("Find Your Dream", style: TextTheme.of(context).headlineSmall),
          Text(
            "Destination With Us",
            style: TextTheme.of(context).headlineSmall,
          ),
          SizedBox(height: height * 0.03),
          Divider(
            height: 3,
            color: Theme.of(context).primaryColor,
            indent: width * 0.06,
            endIndent: width * 0.06,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  InkWell(
                    onTap: () {
                      widget.onTap(true, 1);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/home.svg',
                          width: width * 0.08,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Go To Home",
                          style: TextTheme.of(context).headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Divider(
                    height: 3,
                    color: Theme.of(context).primaryColor,
                    indent: width * 0.01,
                    endIndent: width * 0.01,
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/paint.svg',
                        width: width * 0.08,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Text("Theme", style: TextTheme.of(context).headlineMedium),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    width: width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: 1, color: primaryLight),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedTheme,
                        isExpanded: true,
                        dropdownColor: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColor,
                        ),
                        items: ['Light', 'Dark'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextTheme.of(context).headlineSmall,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue == null) return;
                          setState(() {
                            selectedTheme = newValue;
                          });
                          if (newValue == 'Dark') {
                            themeProvider.setDark();
                          } else {
                            themeProvider.setLight();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Divider(
                    height: 3,
                    color: Theme.of(context).primaryColor,
                    indent: width * 0.01,
                    endIndent: width * 0.01,
                  ),
                  SizedBox(height: height * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RouteNames.chatBot);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/chatgpt.svg',
                          width: width * 0.08,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Text(
                          "Chatbot AI",
                          style: TextTheme.of(context).headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              bottom: height * 0.03,
            ),
            child: CustomButton(
              body: Text("Logout",style: GoogleFonts.inter(color: Colors.white),),
              color: Colors.white,
              backgroundColor: Colors.red,
              onPressed: () async{
                _confirmLogout();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async{
              await SharedPrefService.instance.clearToken();
              Navigator.pushReplacementNamed(context, RouteNames.login);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
