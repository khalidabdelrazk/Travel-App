import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/core/provider/theme_provider.dart';
import 'package:travel/core/routes/routes.dart';
import 'core/di/di.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      routes: Routes.routes,
      // home: ChatScreen(),
    );
  }
}
