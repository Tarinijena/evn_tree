import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:national_wild_animal/GetCurrentLocation.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/GetEventListProvider.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/home_screen_provider.dart';
import 'package:provider/provider.dart';
import 'app/app_routes/app_routes.dart';
import 'app/app_theme/app_themes.dart';
import 'app/module/splash_screen/splash_screen.dart';

//SWAGGER UI BACKEND URL FOR THIS APPLICATION
//http://128.199.18.223:8080/evntree/swagger-ui/index.html#/
//          /evntree/v3/api-docs/


//evn tree event create,event approve/reject , get event base64 document link......
//https://docs.google.com/document/d/1IM63dOHx5Y9yRklL7Cw_mTPHRNAnsmwgi48mLKAjGzs/edit?tab=t.0

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    // systemNavigationBarColor: themeData.scaffoldBackgroundColor,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (_) => EventListProvider()),
      ],
      child: MyApp(),
    ),
    );
  configLoading();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = const Color(0xFF231D32)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVN-TREE',
      theme: AppTheme.getAppTheme(),
      routes: AppRoutes.appRoutes,
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: widget ?? Container(),
        );
      }),
      initialRoute: "/splashScreen",
      home:SplashScreen()
    );
  }
}