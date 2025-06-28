import 'package:delflay_app/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarThemeData(
          splashFactory: NoSplash.splashFactory,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.black54),
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.white,
          height: 65,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // splashFactory: NoSplash.splashFactory,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.black,
        tabBarTheme: TabBarThemeData(
          splashFactory: NoSplash.splashFactory,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelStyle: TextStyle(color: Colors.white54),
        ),
        navigationBarTheme: NavigationBarThemeData(
          surfaceTintColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.black,
          height: 65,
          labelPadding: EdgeInsets.only(top: 0),
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Colors.transparent,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
