import 'dart:async';
import 'dart:io' as plat;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lotti;
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/HistoryViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/NavigationScreen/NavigationScreenView.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RouteScreenViewModel extends GetxController {
  CameraPosition initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  Admob_Helper admob_helper = Admob_Helper();
  double startLatitude1 = 0.0;
  double startLongitude1 = 0.0;
  double destinationLatituate1 = 0.0;
  late BuildContext context;
  RxInt selectedValue = 1.obs;
  double destinationLongitude1 = 0.0;
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
  int valuecheck = -1;

  // late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  HistoryViewModel userController = Get.put(HistoryViewModel());
  bool speechRecognitionAvailable = false;
  String transcription = '';
  RxBool ptts11 = true.obs;
  RxBool ptts12 = true.obs;
  var speech = SpeechToText();
  Timer? debounce;
  bool isListening = false;
  bool ptts1 = true;
  bool ptts2 = true;

  @override
  Future<void> onInit() async {
    print('**** onInit *****');

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
    activateSpeechRecognizer();
    getCurrentLocation();
    admob_helper.loadNativeAd();
    print("is native ad loaded:"+Constent.isNativeAdLoaded.value.toString());
    print("is native ad loaded122:"+admob_helper.nativeAd.toString());
    print("is open ad loaded122:"+Constent.isOpenAppAdShowing.value.toString());
    print("is isInterstialAdShowing ad loaded122:"+Constent.isInterstialAdShowing.value.toString());



   // admob_helper.loadInterstitalAd();
    //admob_helper.loadsmallBannerAd();

    ///Load Ads Here

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getCurrentLocation() async {
    if (Constent.splashcurrentAddress != "") {
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
     /* LocationPermission c=await Geolocator.checkPermission();
      if(c==LocationPermission.always) {*/
        await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
            .then((Position position) async {
          // setState(() {
          currentPosition = position;
          Constent.splashcurrentPosition = currentPosition;
          print('CURRENT POS: $currentPosition');
          //  if (sourcepath == '') {
          /*if (Constent.splashcurrentAddress != "") {
            // Constent.Splashcurrentlath=position.latitude;
            //Constent.Splashcurrentlog=position.longitude;
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                      Constent.Splashcurrentlath, Constent.Splashcurrentlog),
                  zoom: 18.0,
                ),
              ),
            );
            currentAddress = Constent.splashcurrentAddress;
            startAddressController.text = Constent.splashcurrentAddress;
            ;
            startAddress.value = Constent.splashcurrentAddress;
            ;
          }
          else {*/

          // });
          await getAddress();
          /*}
       // }
        else {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(sourcelath!, sourcelog!),
                zoom: 18.0,
              ),
            ),
          );
          markers:
          Set<Marker>.from(markers);
          initialCameraPosition:
          initialLocation;
          currentAddress = sourcepath!;
          startAddressController.text = currentAddress;
          startAddress.value = currentAddress;
          destinationAddress.value = destinationpath!;
          destinationAddressController.text = destinationpath!;
          performSearch('');
        }*/
        }).catchError((e) {
          print(e);
        });
   //   }
    /*  else{

    LocationPermission p=await Geolocator.requestPermission();
    if(p==LocationPermission.always) {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        // setState(() {
        currentPosition = position;
        Constent.splashcurrentPosition = currentPosition;
        print('CURRENT POS: $currentPosition');
        //  if (sourcepath == '') {
        *//*if (Constent.splashcurrentAddress != "") {
            // Constent.Splashcurrentlath=position.latitude;
            //Constent.Splashcurrentlog=position.longitude;
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                      Constent.Splashcurrentlath, Constent.Splashcurrentlog),
                  zoom: 18.0,
                ),
              ),
            );
            currentAddress = Constent.splashcurrentAddress;
            startAddressController.text = Constent.splashcurrentAddress;
            ;
            startAddress.value = Constent.splashcurrentAddress;
            ;
          }
          else {*//*

        // });
        await getAddress();
        *//*}
       // }
        else {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(sourcelath!, sourcelog!),
                zoom: 18.0,
              ),
            ),
          );
          markers:
          Set<Marker>.from(markers);
          initialCameraPosition:
          initialLocation;
          currentAddress = sourcepath!;
          startAddressController.text = currentAddress;
          startAddress.value = currentAddress;
          destinationAddress.value = destinationpath!;
          destinationAddressController.text = destinationpath!;
          performSearch('');
        }*//*
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
      currentAddress = currentAddress.replaceAll(RegExp(r'^,+,'), '');
      startAddressController.text = currentAddress;
      startAddress.value = currentAddress;
      //  });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  /*Future<bool> calculateDistance() async {
    try {
      print("inside local hereeee");
      double startLatitude=0.0, startLongitude=0.0,destinationLatitude=0.0,destinationLongitude=0.0;
      // Retrieving placemarks from addresses

      if(sourcepath==''){
        List<Location> startPlacemark = await locationFromAddress(startAddress.value);
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
      }
      else{

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

      }
      startLatitude1=startLatitude;
      startLongitude1=startLongitude;
      destinationLatituate1=destinationLatitude;
      destinationLongitude1=destinationLongitude;
      if(startAddress!='' && destinationAddress!=''){
        await userController.addUser(
          startAddress.value,
          destinationAddress.value,
          startLongitude1,
          startLatitude1,
          destinationLongitude1,
          destinationLatituate1,





        );
      }
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
      */ /*mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(northEastLatitude+0.999,
            northEastLongitude-0.999,),
          5));*/ /*
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          150.0,
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
  }*/

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

  /* openMap(double startLatitude,double startLongitude,double destinationLatitude,double destinationLongitude) async {
      String current=startLatitude1.toString()+","+startLongitude1.toString();
      String seach=destinationLatituate1.toString()+","+destinationLongitude1.toString();
      String googleUrl='';
    print("model value is:"+selectedValue.value.toString());
    String modevalue='';
    if(selectedValue.value==1){
      modevalue="driving";
    }
    else if(selectedValue.value==2){
      modevalue="Bicycling";
    }
    else if(selectedValue.value==3){
      modevalue="walking";
    }
   */ /* else if(selectedValue.value==4){
      modevalue="Transit";
    }*/ /*
    print("model String value is:"+modevalue);
    // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving &dir_action=navigate';
    if(startAddressController.text !="" && destinationAddressController.text!=""){
      if(startLatitude == 0.0 && startLongitude == 0.0 && destinationLatitude == 0.0 && destinationLongitude == 0.0){
        performSearch('');
        Future.delayed(const Duration(milliseconds: 2000), () async {
          //viewModel.openMap(viewModel.startLatitude1,viewModel.startLongitude1,viewModel.destinationLatituate1, viewModel.destinationLongitude1),

          //String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude1,$startLongitude1&destination=$destinationLatituate1,$destinationLongitude1&travelmode=driving';

          if(  modevalue=="driving"){
           googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=d";
          }
         else if(  modevalue=="Bicycling"){
            googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
          }
         else if(modevalue=="walking"){
            googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=w";
          }
          //String googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
          //String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude1,$startLongitude1&destination=$destinationLatituate1,$destinationLongitude1&travelmode='+modevalue;
          if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
          } else {
          throw 'Could not open the map.';
          }
// Here you can write your code



        });

      }

      else{
       // String googleUrl='';
        if(  modevalue=="driving"){
          googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=d";
        }
        else if(  modevalue=="Bicycling"){
          googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
        }
        else if(modevalue=="walking"){
          googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=w";
        }
       // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving';
       // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode='+modevalue;
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    }
    else{
      if(startAddressController.text ==""){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Current location Cannot be Empty")));
      }
      else if(destinationAddressController.text ==""){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Destination Location Cannot be Empty ")));
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Source and Destination Location Cannot be Empty ")));
      }

    }

  }*/

/*  openMap(double startLatitude,double startLongitude,double destinationLatitude,double destinationLongitude) async {
    String current=startLatitude1.toString()+","+startLongitude1.toString();
    String seach=destinationLatituate1.toString()+","+destinationLongitude1.toString();
    String googleUrl='';
    print("model value is:"+selectedValue.value.toString());
    String modevalue='';
    if(selectedValue.value==1){
      modevalue="driving";
    }
    else if(selectedValue.value==2){
      modevalue="Bicycling";
    }
    else if(selectedValue.value==3){
      modevalue="walking";
    }
    */ /* else if(selectedValue.value==4){
      modevalue="Transit";
    }*/ /*
    print("model String value is:"+modevalue);
    // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving &dir_action=navigate';
    if(startAddressController.text !="" && destinationAddressController.text!=""){
      if(startLatitude == 0.0 && startLongitude == 0.0 && destinationLatitude == 0.0 && destinationLongitude == 0.0){
        performSearch('');
        Future.delayed(const Duration(milliseconds: 2000), () async {
          //viewModel.openMap(viewModel.startLatitude1,viewModel.startLongitude1,viewModel.destinationLatituate1, viewModel.destinationLongitude1),

          //String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude1,$startLongitude1&destination=$destinationLatituate1,$destinationLongitude1&travelmode=driving';

          if(modevalue=="driving"){
            if(plat.Platform.isIOS){
              googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=d";

              //googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=driving";
              //googleUrl = 'comgooglemaps://?saddr=&daddr=$destinationLatituate1,$destinationLongitude1&directionsmode=driving';
              // googleUrl=  Uri.parse("google.navigation:q=$startLatitude1,$destinationLongitude1&mode=d").toString();
            }
            if(plat.Platform.isAndroid){
              googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=d";
            }

          }
          else if(modevalue=="Bicycling"){
            if(plat.Platform.isIOS){
              googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=b";

              // googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=bicycling";
            }
            if(plat.Platform.isAndroid){
              googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
            }
          }
          else if(modevalue=="walking"){
            if(plat.Platform.isIOS){
              googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=w";

              // googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=walking";
              //googleUrl = 'comgooglemaps://?saddr=&daddr=$destinationLatituate1,$destinationLongitude1&directionsmode=driving';
              // googleUrl=  Uri.parse("google.navigation:q=$startLatitude1,$destinationLongitude1&mode=d").toString();
            }
            if(plat.Platform.isAndroid) {
              googleUrl =
                  "http://maps.google.com/maps?saddr=" + current + " &daddr=" +
                      seach + "&dirflg=w";
            }
          }
          //String googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
          //String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude1,$startLongitude1&destination=$destinationLatituate1,$destinationLongitude1&travelmode='+modevalue;
          if (await canLaunch(googleUrl)) {
            await launch(googleUrl);
          } else {
            throw 'Could not open the map.';
          }
// Here you can write your code



        });

      }

      else{
        // String googleUrl='';
        if(  modevalue=="driving"){
          if(plat.Platform.isIOS){
            googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=d";

            //  googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=driving";

            //  googleUrl = 'comgooglemaps://?saddr=&daddr=$destinationLatituate1,$destinationLongitude1&directionsmode=driving';

            //   googleUrl=  Uri.parse("google.navigation:q=$startLatitude1,$destinationLongitude1&mode=d").toString();
          }
          if(plat.Platform.isAndroid){
            googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=d";
          }
        }
        else if(  modevalue=="Bicycling"){
          if(plat.Platform.isIOS){
            googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=b";

            // googleUrl= "http://maps.apple.com/maps?daddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=b";

//   googleUrl = "http://maps.apple.com/maps?daddr=\(destinationLocation.latitude),\(destinationLocation.longitude)&dirflg=d"''
            //googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=bicycling";
          }
          if(plat.Platform.isAndroid){
            googleUrl=  "http://maps.google.com/maps?saddr="+current+" &daddr="+seach+ "&dirflg=b";
          }}
        else if(modevalue=="walking"){
          if(plat.Platform.isIOS){
            googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&dirflg=w";

            //googleUrl= "https://www.google.co.in/maps/dir/?saddr="+startLatitude1.toString()+","+startLongitude1.toString()+","+"&daddr="+destinationLatituate1.toString()+","+destinationLongitude1.toString()+","+"&directionsmode=walking";
            //googleUrl = 'comgooglemaps://?saddr=&daddr=$destinationLatituate1,$destinationLongitude1&directionsmode=driving';
            // googleUrl=  Uri.parse("google.navigation:q=$startLatitude1,$destinationLongitude1&mode=d").toString();
          }
          if(plat.Platform.isAndroid) {
            googleUrl =
                "http://maps.google.com/maps?saddr=" + current + " &daddr=" +
                    seach + "&dirflg=w";
          }
        }
        // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving';
        // String googleUrl='https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$destinationLatitude,$destinationLongitude&travelmode='+modevalue;
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    }
    else{
      if(startAddressController.text ==""){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Current location Cannot be Empty")));
      }
      else if(destinationAddressController.text ==""){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Destination Location Cannot be Empty ")));
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Source and Destination Location Cannot be Empty ")));
      }

    }

  }*/

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
    print("show start address:" + startAddressController.text);
    print("show dest address:" + destinationAddressController.text);
    if (startAddressController.text != "" &&
        destinationAddressController.text != "") {
      markers.clear();
      polylines.clear();
      polylineCoordinates.clear();
      placeDistance.value = '';

      calculateDistance();

      // .then((isCalculated) {
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
      // });
    } else {
      if (startAddressController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Current location Cannot be Empty")));
      } else if (destinationAddressController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Destination Location Cannot be Empty ")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Source and Destination Location Cannot be Empty ")));
      }
    }

//    FocusScope.of(context).requestFocus(FocusNode());
  }

  calculateDistance() async {
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

     // admob_helper.showInterstitialAd(callback: () {
        Get.to(() => NavigationScreenView(), arguments: {
          "source": startAddressController.text,
          "destination": destinationAddressController.text,
          "Sourcelath": startLatitude,
          "Sourcelog": startLongitude,
          "destinationlath": destinationLatitude,
          "destinationlog": destinationLongitude
       // });
      }
      );

      // }
      /* else{

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
      /*startLatitude1=startLatitude;
      startLongitude1=startLongitude;
      destinationLatituate1=destinationLatitude;
      destinationLongitude1=destinationLongitude;
      if(startAddress!='' && destinationAddress!=''){
        await userController.addUser(
          startAddress.value,
          destinationAddress.value,
          startLongitude1,
          startLatitude1,
          destinationLongitude1,
          destinationLatituate1,





        );
      }
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
      double northEastLongitude = maxx;*/

      // Accommodate the two locations within the
      // camera view of the map
      //   if(sourcepath=='') {
      /*mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
          LatLng(northEastLatitude+0.999,
            northEastLongitude-0.999,),
          5));*/
      /*     mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          150.0,
        ),
      );*/

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      /*  await _createPolylines(startLatitude, startLongitude, destinationLatitude,
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
      print('DISTANCE: $placeDistance km');*/
      //  });

      // return true;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No address found for given location")));
      print(e);
    }
    // return false;
  }

  Future<void> activateSpeechRecognizer() async {
    debugPrint('_MyAppState.activateSpeechRecognizer... ');
    speech = SpeechToText();

    speechRecognitionAvailable = await speech.initialize(
        onError: errorHandler, onStatus: onSpeechAvailability);
  }

  void onSpeechAvailability(String status) {
    //setState(() {
    speechRecognitionAvailable = speech.isAvailable;
    isListening = speech.isListening;
    // }
  }

  void onRecognitionResult(SpeechRecognitionResult result) {
    //  setState(() =>

    if (result.recognizedWords.isNotEmpty) {
      print("Search:" + result.recognizedWords);
      transcription = result.recognizedWords;
      if (valuecheck == 1) {
        startAddressController.text = transcription;
        startAddress.value = transcription;
      } else if (valuecheck == 2) {
        destinationAddressController.text = transcription;
        destinationAddress.value = transcription;
      }

      print("show start address13:" + startAddressController.text);
      print("show dest address123:" + destinationAddressController.text);
      print("Search1:" + transcription);

      /*  if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 1000), () {
        print("call hereee1234 inside");
        performSearch('');
      });*/
    }
    //filterSearchResults(editingController.text);
    // if(editingController.text)
  }

  //   );

  // void onRecognitionComplete() => setState(() => _isListening = false);

  void errorHandler(SpeechRecognitionError error) {
    print("i am herrreeee124:" + ptts11.value.toString());
    //ptts11.value=true;
    offMic();

    debugPrint(error.errorMsg);
  }

  void start() {
    print("start function call:" + ptts11.value.toString());
    speech.listen(onResult: onRecognitionResult, localeId: 'en');
  }

  void destinationsreach() {
    if (ptts2) {
      print("call mic heree" + speechRecognitionAvailable.toString());
      print("call mic heree1" + isListening.toString());
      if (speechRecognitionAvailable && !isListening) {
        //viewModel.ptts11.value=false,
        onMic2();
        print("value of false 1234:" + ptts12.value.toString());
        ptts2 = false;
        start();
      }
    } else {
      //viewModel.ptts11.value=true,
      offMic2();
      ptts2 = true;
      speech.cancel();
      speech.stop();
    }
    ;
  }

  void offMic() {
    ptts11.value = true;
  }

  void onMic() {
    ptts11.value = false;
  }

  void offMic2() {
    ptts12.value = true;
  }

  void onMic2() {
    ptts12.value = false;
  }

  micpopup(BuildContext context) async {
    return await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            lotti.Lottie.asset(
              height: 200.0,
              'assets/micnew.json',
              repeat: true,
              reverse: true,
              animate: true,
            ),
            Text(
              "Speak Now",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),

        /*actions: [
              Text("Speak Now",
                  style: TextStyle(color: Colors.black), textAlign: TextAlign.left,),
              */ /*ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No",style: TextStyle(
                    color: Colors.white,
                  ),)
              ),*/ /*
            ],*/
      ),
    );
  }

  void startTimer(BuildContext context) {
    micpopup(context);

    Future.delayed(Duration(seconds: 5), () {
      //  print("Show progress bar value");

      Navigator.of(context).pop(false);
      /*if (ptts1) {
        print("call mic heree"+speechRecognitionAvailable.toString());
        print("call mic heree1"+isListening.toString());
        if(speechRecognitionAvailable && !isListening)
            {
          //viewModel.ptts11.value=false,
         onMic();
          print("value of false 1234:"+ptts11.value.toString());
          ptts1=false;
         start();
            }
     }
     else
      {*/
      //viewModel.ptts11.value=true,
      offMic();
      ptts1 = true;
      speech.cancel();
      speech.stop();
      //  };
    });
  }

  void startTimer1(BuildContext context) {
    micpopup(context);

    Future.delayed(Duration(seconds: 5), () {
      //  print("Show progress bar value");

      Navigator.of(context).pop(false);

      offMic2();
      ptts2 = true;
      speech.cancel();
      speech.stop();
      //  };
    });
  }
}
