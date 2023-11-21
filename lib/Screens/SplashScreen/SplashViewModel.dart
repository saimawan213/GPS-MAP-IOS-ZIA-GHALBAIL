import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/AppLifecycleReactor.dart';
import 'package:permission_handler/permission_handler.dart';


class SplashViewModel extends GetxController {
  RxDouble progressValue = 0.0.obs;
  late AppLifecycleReactor appLifecycleReactor;
  Admob_Helper admob_helper = Admob_Helper();
  RxBool showProgressBar = true.obs;


  @override
  Future<void> onInit() async {
    print('**** onInit *****');

    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');
    ///Load Ads Here
    checkPermission();
    startLoading();
    Admob_Helper admob_helper1 = Admob_Helper()
      ..loadopenupad();
    appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: admob_helper1);
    appLifecycleReactor.listenToAppStateChanges();
    admob_helper.loadInterstitalAd();
    admob_helper.loadsmallBannerAd();
  //  startTimer();

    super.onReady();
  }
  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();
  }
  void startTimer() {
    Future.delayed(Duration(seconds: 4), () {
      //  print("Show progress bar value");
      showProgressBar.value = false;

    });
  }
  Future<bool?> checkPermission() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statues =
      await [Permission.camera, Permission.locationWhenInUse].request();
      PermissionStatus? statusCamera = statues[Permission.camera];

      PermissionStatus? statuslocation = statues[Permission.locationWhenInUse];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statuslocation == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statuslocation == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        return false;
      }
    } else {
      Map<Permission, PermissionStatus> statues = await [
        Permission.camera,
        Permission.storage,
        Permission.locationWhenInUse
      ].request();
      PermissionStatus? statusCamera = statues[Permission.camera];
      PermissionStatus? statusStorage = statues[Permission.storage];
      PermissionStatus? statuslocation = statues[Permission.locationWhenInUse];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusStorage == PermissionStatus.granted &&
          statuslocation == PermissionStatus.granted;
      if (isGranted) {
        return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusStorage == PermissionStatus.permanentlyDenied ||
              statuslocation == PermissionStatus.permanentlyDenied;
      if (isPermanentlyDenied) {
        return false;
      }
    }
  }
  void startLoading() {
    const totalDuration = Duration(seconds: 5); // Adjust the duration as needed
    const updateFrequency = Duration(milliseconds: 100);

    final totalSteps = totalDuration.inMilliseconds ~/ updateFrequency.inMilliseconds;

    int currentStep = 0;

    Timer.periodic(updateFrequency, (Timer timer) {
      if (currentStep >= totalSteps) {
        //setState(() {
        progressValue.value = 100.0;

      //  });
        timer.cancel();
        showProgressBar.value = false;
      } else {
     //   setState(() {
          progressValue.value = (currentStep / totalSteps) * 100;
       // });
        currentStep++;
      }
    });
  }


}
