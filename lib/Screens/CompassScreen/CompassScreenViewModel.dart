import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';


class CompassScreenViewModel extends GetxController {
  RxString compassDirection = "N".obs;
  RxDouble compassvalue= (0.0).obs;
  RxBool hasPermissions = false.obs;
  CompassEvent? lastRead;
 Admob_Helper admob_helper = Admob_Helper();
  DateTime? lastReadAt;

  @override
  Future<void> onInit() async {
    print('**** onInit *****');

    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');
    ///Load Ads Here
    requestPermission();
    admob_helper.loadsmallBannerAd();

    FlutterCompass.events?.listen((CompassEvent event) {

        print('direction is1:'+event.heading.toString());
        //List values = event.heading.toString().split(".");
        //  bool a= isNumeric(event.heading.toString());
        print('direction 123 first:'+sanitizeHeading(event.heading).toString());
        compassDirection.value = _getCompassDirection(sanitizeHeading(event.heading));
        compassvalue.value=sanitizeHeading(event.heading);

      });
    /*if(!a){
       // String s = "Hello World!";
        print('direction 123 first:'+sanitizeHeading(event.heading).toString());
        print(event.heading.toString().substring(1));
        print('direction is123:'+event.heading.toString());
        compassDirection = _getCompassDirection(double.parse(event.heading.toString().substring(1)));
      }
      else{
        compassDirection = _getCompassDirection(double.parse(event.heading.toString()));
      }*/

    //   compassDirection = _getCompassDirection(event.heading.toString());
    super.onReady();
  }
  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();
  }
 /* void fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
     // if (mounted) {
     //   setState(() => _hasPermissions = status == PermissionStatus.granted); setState(() => _hasPermissions = status == PermissionStatus.granted);

     // }
  hasPermissions.value = status == PermissionStatus.granted;
    });

  }*/
  Future<void> requestPermission() async {
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
    hasPermissions.value=true;
 /*   LocationPermission c=await Geolocator.checkPermission();
    if(c==LocationPermission.always){
      hasPermissions.value=true;
    }
    else {
      LocationPermission p=await Geolocator.requestPermission();
      if(p==LocationPermission.always){
        hasPermissions.value=true;
      }
    }*/
    /*Permission.locationWhenInUse.request().then((ignored) {
      fetchPermissionStatus();
    });*/
  }
  double sanitizeHeading(double? hd) {
    if (hd == null) return 0;
    if (hd < 0) return 360 + hd;
    if (hd > 0) return hd;
    return hd;
  }
  String _getCompassDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) {
      return "N";
    } else if (heading >= 22.5 && heading < 67.5) {
      return "NE";
    } else if (heading >= 67.5 && heading < 112.5) {
      return "E";
    } else if (heading >= 112.5 && heading < 157.5) {
      return "SE";
    } else if (heading >= 157.5 && heading < 202.5) {
      return "S";
    } else if (heading >= 202.5 && heading < 247.5) {
      return "SW";
    } else if (heading >= 247.5 && heading < 292.5) {
      return "W";
    } else {
      return "NW";
    }
  }

}
