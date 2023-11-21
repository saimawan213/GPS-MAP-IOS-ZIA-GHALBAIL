import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mapsandnavigationflutter/Screens/SplashScreen/SplashView.dart';
import 'package:mapsandnavigationflutter/Screens/WorldClockScreen/SelectlcoationView.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


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
        GetPage(name: '/', page: () => SplashView()),
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