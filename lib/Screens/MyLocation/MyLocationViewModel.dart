import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constents/Constent.dart';

class MyLocationViewModel extends GetxController {
  CameraPosition initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

  late GoogleMapController mapController;
  late double startLatitude1;
  late double startLongitude1;
  late double destinationLatituate1;
  late double destinationLongitude1;
  late Position currentPosition;
  String currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  RxString startAddress = ''.obs;
  RxString destinationAddress = ''.obs;
  RxString placeDistance = ''.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  //Set<Marker> markers = {};

  // late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  /* String? sourcepath,destinationpath;
  double? sourcelath,sourcelog,destinationlath,destinationlog;
  HistoryViewModel  userController = Get.put(HistoryViewModel());*/

  @override
  Future<void> onInit() async {
    print('**** onInit *****');
    /*  sourcelath=Get.arguments['Sourcelath'];
    sourcelog=Get.arguments['Sourcelog'];
    destinationlath=Get.arguments['destinationlath'];
    destinationlog=Get.arguments['destinationlog'];
    sourcepath = Get.arguments['source'];
    destinationpath = Get.arguments['destination'];*/

    /* if(sourcepath == ''){

      print("i am in current location");
      getCurrentLocation();
    }
    else{
     */ /* Future.delayed(Duration(seconds: 2), (){
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(sourcelath!, sourcelog!),
              zoom: 18.0,
            ),
          ),
        );*/ /*
        //  final double souclog=sourcelog!;

        markers: Set<Marker>.from(markers);
        initialCameraPosition: initialLocation;
        currentAddress=sourcepath!;
        startAddressController.text = currentAddress;
        startAddress.value = currentAddress;
        destinationAddress.value=destinationpath!;
        destinationAddressController.text=destinationpath!;
        performSearch('');
        // Your code over here
     // });

    }*/
    //getCurrentLocation();
    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');

    ///Load Ads Here

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getCurrentLocation() async {
    if (Constent.splashcurrentAddress != "") {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(Constent.Splashcurrentlath, Constent.Splashcurrentlog),
            zoom: 18.0,
          ),
        ),
      );
      currentAddress = Constent.splashcurrentAddress;
      startAddressController.text = Constent.splashcurrentAddress;
      startAddress.value = Constent.splashcurrentAddress;
      currentPosition = Constent.splashcurrentPosition;

      /* Set<Marker>.from(markers);
      initialCameraPosition:
      initialLocation;
      currentAddress = sourcepath!;
      startAddressController.text = currentAddress;
      startAddress.value = currentAddress;
      destinationAddress.value = destinationpath!;
      destinationAddressController.text = destinationpath!;
      performSearch('');*/
      // performSearch('');
    } else {
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
      /*  LocationPermission  c=await Geolocator.checkPermission();

      if(c==LocationPermission.always){*/
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        // setState(() {
        currentPosition = position;
        print('CURRENT POS: $currentPosition');
        //  if(sourcepath == '') {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
        // });
        await getAddress();
        // }
        /*    else{
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(sourcelath!, sourcelog!),
              zoom: 18.0,
            ),
          ),
        );
        markers: Set<Marker>.from(markers);
        initialCameraPosition: initialLocation;
        currentAddress=sourcepath!;
        startAddressController.text = currentAddress;
        startAddress.value = currentAddress;
        destinationAddress.value=destinationpath!;
        destinationAddressController.text=destinationpath!;
        performSearch('');
      }*/
      }).catchError((e) {
        print(e);
      });
      // }
      /*    else{
        LocationPermission p=await Geolocator.requestPermission();
        if(p==LocationPermission.always){
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
    // setState(() {
    currentPosition = position;
    print('CURRENT POS: $currentPosition');
    //  if(sourcepath == '') {
    mapController.animateCamera(
    CameraUpdate.newCameraPosition(
    CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: 18.0,
    ),
    ),
    );
    // });
    await getAddress();
    // }
    */ /*    else{
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(sourcelath!, sourcelog!),
              zoom: 18.0,
            ),
          ),
        );
        markers: Set<Marker>.from(markers);
        initialCameraPosition: initialLocation;
        currentAddress=sourcepath!;
        startAddressController.text = currentAddress;
        startAddress.value = currentAddress;
        destinationAddress.value=destinationpath!;
        destinationAddressController.text=destinationpath!;
        performSearch('');
      }*/ /*
    }).catchError((e) {
    print(e);
    });
    }

  }*/
    }
  }

/*  getCurrentLocation() async {
    print('call heeee');
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
    //  setState(() {
        print("current position: "+currentPosition.toString());
        currentPosition = position;
        print('CURRENT POS: $currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      //}
     // );
      await getAddress();
    }).catchError((e) {
      print(e);
    });
  }*/
/*onMapcreated(GoogleMapController controller){
  mapController.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18.0,
      ),
    ),
  );
}*/
  // Method for retrieving the address
  getCurrentLocation1() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // setState(() {
      currentPosition = position;
      print('CURRENT POS: $currentPosition');
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
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      //  setState(() {
      currentAddress =
          "${place.street},${place.subLocality},${place.locality}, ${place.administrativeArea}, ${place.country}";
      startAddressController.text = currentAddress;
      startAddress.value = currentAddress;
      //  });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> calculateDistance() async {
    try {
      print("inside local hereeee");
      double startLatitude = 0.0,
          startLongitude = 0.0,
          destinationLatitude = 0.0,
          destinationLongitude = 0.0;
      // Retrieving placemarks from addresses

      // if(sourcepath==''){
      List<Location> startPlacemark =
          await locationFromAddress(startAddress.value);
      List<Location> destinationPlacemark =
          await locationFromAddress(destinationAddress.value);
      print("inside local hereee123e");
      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      startLatitude = startAddress == currentAddress
          ? currentPosition.latitude
          : startPlacemark[0].latitude;

      startLongitude = startAddress == currentAddress
          ? currentPosition.longitude
          : startPlacemark[0].longitude;

      destinationLatitude = destinationPlacemark[0].latitude;
      destinationLongitude = destinationPlacemark[0].longitude;
      //  }
      /*  else{

        startLatitude= sourcelath!;
        startLongitude=sourcelog!;
        destinationLatitude=  destinationlath!;
        destinationLongitude= destinationlog!;
        sourcelath=0.0;
        sourcelog=0.0;
        destinationlath=0.0;
        destinationlog=0.0;
        sourcepath='';
        destinationpath='';

      }*/
      startLatitude1 = startLatitude;
      startLongitude1 = startLongitude;
      destinationLatituate1 = destinationLatitude;
      destinationLongitude1 = destinationLongitude;
      /*    if(startAddress!='' && destinationAddress!=''){
        await userController.addUser(
          startAddress.value,
          destinationAddress.value,
          startLongitude1,
          startLatitude1,
          destinationLongitude1,
          destinationLatituate1,





        );
      }*/
//openMap(startLatitude,startLongitude,destinationLatitude, destinationLongitude);
      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: startAddress.value,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: destinationAddress.value,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      //   if(sourcepath=='') {
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      //   setState(() {
      placeDistance.value = totalDistance.toStringAsFixed(2);
      print('DISTANCE: $placeDistance km');
      //  });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<void> openMap(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) async {
    // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving &dir_action=navigate';
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  // Create the polylines for showing the route between two places

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    //  polylinePoints = PolylinePoints();
    /*   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );*/
    /* PointLatLng(startLatitude, startLongitude),
    PointLatLng(destinationLatitude, destinationLongitude),*/
    //print("points result1234:"+Secrets.API_KEY.toString());
/*    if (result.points.isNotEmpty) {
       print("points result:"+result.points.toString());
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }*/
    polylineCoordinates.add(LatLng(startLatitude, startLongitude));
    polylineCoordinates.add(LatLng(destinationLatitude, destinationLongitude));
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  performSearch(query) async {
    if (startAddress == '') {
      getCurrentLocation1();
      startAddressController.text = currentAddress;
      startAddress.value = currentAddress;
    }

//    FocusScope.of(context).requestFocus(FocusNode());
    markers.clear();
    polylines.clear();
    polylineCoordinates.clear();
    placeDistance.value = '';

    calculateDistance().then((isCalculated) {
      /*   if (isCalculated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
                'Distance Calculated Sucessfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text(
                'Error Calculating Distance'),
          ),
        );
      }*/
    });
  }
}
