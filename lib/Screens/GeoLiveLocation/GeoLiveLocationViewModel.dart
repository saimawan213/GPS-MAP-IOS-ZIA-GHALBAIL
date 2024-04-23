import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper_Impl.dart';

import 'package:widgets_to_image/widgets_to_image.dart';

class GeoLiveLocationViewModel extends GetxController {
  final picker = ImagePicker();

  Admob_Helper admob_helper = Admob_Helper();
  Rx<File> imageFile = File('').obs;
  RxString currentAddress = ''.obs;
  WidgetsToImageController controller = WidgetsToImageController();
  Image? image;
  File? file;
  String? imagepath;
  Uint8List? bytes;
  RxString actualDate = ''.obs;
  RxString actualTime = ''.obs;
  late Position currentPosition;
  @override
  Future<void> onInit() async {
    print('**** onInit *****');
    getCurrentLocation();

    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');

    ///Load Ads Here
    // checkPermission();
    admob_helper.adaptiveloadAd();
    // admob_helper.loadsmallBannerAd();
    imgFromCamera();
    var now = DateTime.now();
    var formatterDate = DateFormat("EEEE, MM-dd-yyyy");
    var formatterTime = DateFormat("hh:mm a");
    actualDate.value = formatterDate.format(now);
    actualTime.value = formatterTime.format(now);
    print("Date :" + actualDate.value);
    print("Time :" + actualTime.value);
    // DateTime now = DateTime.now();
    // print(now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString());
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    admob_helper.isBannerLoaded.value = false;
    admob_helper.anchoredAdaptiveAd = null;
  }

/*  Future<bool?> checkPermission() async {
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
  }*/
  imgFromCamera() async {
    print("Present  imgFromCamera");
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        Future.delayed(Duration.zero, () {
          imageFile.value = (File(value.path));
          print('image value:' + imageFile.value.toString());
          //  _cropImage(File(value.path));
        });
      }
    });
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      //  setState(() {
      currentPosition = position;
      print('CURRENT POS: $currentPosition');
      /*    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );*/
      //}
      // );
      await getAddress();
    }).catchError((e) {
      print(e);
    });
    /*  LocationPermission  c=await Geolocator.checkPermission();
    if(c==LocationPermission.always) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        //  setState(() {
        currentPosition = position;
        print('CURRENT POS: $currentPosition');
        */ /*    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );*/ /*
        //}
        // );
        await getAddress();
      }).catchError((e) {
        print(e);
      });
    }*/
    /*   else {
      LocationPermission p=await Geolocator.requestPermission();
      if(p==LocationPermission.always){
        await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
            .then((Position position) async {
          //  setState(() {
          currentPosition = position;
          print('CURRENT POS: $currentPosition');
          */ /*    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );*/ /*
          //}
          // );
          await getAddress();
        }).catchError((e) {
          print(e);
        });
      }
    }*/
  }

  // Method for retrieving the address
  getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      //  setState(() {
      currentAddress.value =
          "${place.street},${place.subLocality},${place.locality}, ${place.administrativeArea}, ${place.country}";
      print("current location:" + currentAddress.toString());
      // startAddressController.text = currentAddress;
      // startAddress.value = currentAddress;
      //  });
    } catch (e) {
      print(e);
    }
  }
}
