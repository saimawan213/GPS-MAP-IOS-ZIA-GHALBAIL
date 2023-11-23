import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/AppLifecycleReactor.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:permission_handler/permission_handler.dart';


class SplashViewModel extends GetxController {
  RxDouble progressValue = 0.0.obs;
  late AppLifecycleReactor appLifecycleReactor;
  Admob_Helper admob_helper = Admob_Helper();
RxString currentlocation=''.obs;

  RxBool showProgressBar = true.obs;


  @override
  Future<void> onInit() async {
    print('**** onInit *****');

    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  void onReady() async{
    print('**** onReady *****');
    ///Load Ads Here
    if(await checkPermission()){
      getCurrentLocation();
    }
    //checkPermission();
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
  Future<bool> checkPermission() async {
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
      return false;
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
      return false;
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
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // setState(() {
      Constent.splashcurrentPosition = position;
      print('CURRENT POS: $Constent.splashcurrentPosition');
      Constent.Splashcurrentlath=position.latitude;
      Constent.Splashcurrentlog=position.longitude;
     /*   mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );*/
        // });
        await getAddress();


    }).catchError((e) {
      print(e);
    });
  }
  getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          Constent.splashcurrentPosition.latitude, Constent.splashcurrentPosition.longitude);

      Placemark place = p[0];

      //  setState(() {
      Constent.splashcurrentAddress =
      "${place.street},${place.subLocality},${place.locality}, ${place.administrativeArea}, ${place.country}";
      Constent.splashcurrentAddress= Constent.splashcurrentAddress.replaceAll(RegExp(r'^,+,'), '');
      currentlocation.value=  Constent.splashcurrentAddress;
      // currentlocation.value=Constent.splashcurrentAddress;
    /*  startAddressController.text = currentAddress;
      startAddress.value = currentAddress;*/
      //  });
    } catch (e) {
      print(e);
    }
  }
}
