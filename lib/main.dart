import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/SplashScreen/SplashView.dart';
import 'package:mapsandnavigationflutter/Screens/SplashScreen/SplashViewIos.dart';
import 'package:mapsandnavigationflutter/Screens/WorldClockScreen/SelectlcoationView.dart';
import 'package:mapsandnavigationflutter/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  ///Lock Screen Rotation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    // name: 'document-scanner-ios-f743a',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MobileAds.instance.initialize();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  runApp(MyApp());

  //FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final InAppPurchase _inAppPurchase = InAppPurchase.instance;
    // _inAppPurchase.restorePurchases();
    return GetMaterialApp(

      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashViewIos()),
        GetPage(name: '/location', page: () => SelectlcoationView()),
      //  GetPage(name: '/ShowImage', page: () =>  PhotoViewerscreen(galleryItems: galleryItems)),

      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Splash_View(),
    );
  }
}