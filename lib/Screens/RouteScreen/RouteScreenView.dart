import 'dart:async';
import 'dart:ffi';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/HistoryViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/NavigationScreen/NavigationScreenViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/NativeAdSkeleton.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/RouteScreenViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/SmallNativeAdSkeleton.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';



class RouteScreenView extends StatelessWidget {
  RouteScreenViewModel  viewModel = Get.put(RouteScreenViewModel());

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required TextInputAction textInputAction,
    // required Icon prefixIcon,
    Widget? prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
      /*  onSubmitted: (String query) {
          if (viewModel.debounce?.isActive ?? false) viewModel.debounce?.cancel();
          viewModel.debounce = Timer(const Duration(milliseconds: 1000), () {
            print("call hereee1234 inside");
            viewModel.performSearch(query);
          });

        },*/
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location

  // Create the polylines for showing the route between two places


  @override
  Widget build(BuildContext context) {

    viewModel.context=context;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Route Finder', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.yellowColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // or MenuOutlined
          onPressed: () {
            Get.back();
            print("call in app ");
            // Get.to(() => InApp());
            //  Get.to(/InApp);
            //InApp inAppfile= InApp();
            //viewModel.inAppfile;
            // Open the drawer here
          },
        ),
      ),
        body:Container(
          height: height,
          width: width,
          child: Scaffold(
            resizeToAvoidBottomInset : false,
            key: _scaffoldKey,
            body: Column(
              children: <Widget>[
              /*  Obx(()=>
                // Map View
                GoogleMap(
                  markers: Set<Marker>.from(viewModel.markers),
                  initialCameraPosition: viewModel.initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(viewModel.polylines.values),
                  //  onMapCreated: viewModel.onMapcreated(GoogleMapController),
                  onMapCreated: (GoogleMapController controller) {
                    viewModel.mapController = controller;
                    viewModel.getCurrentLocation();
                  },
                )),*/
                // Show zoom buttons
               /* SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.green.shade100, // button color
                            child: InkWell(
                              splashColor: AppColor.primaryColor, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.add),
                              ),
                              onTap: () {
                                viewModel.mapController.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipOval(
                          child: Material(
                            color: Colors.green.shade100, // button color
                            child: InkWell(
                              splashColor: AppColor.primaryColor, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.remove),
                              ),
                              onTap: () {
                                viewModel.mapController.animateCamera(
                                  CameraUpdate.zoomOut(),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
                // Show the place input fields & button for
                // showing the route
                SizedBox(height: 20),
              Expanded(
              flex: 4,
              child:Container(


                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),


                 // Adjust the radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /*  Text(
                                'Navigation',
                                style: TextStyle(fontSize: 20.0),
                              ),*/
                      SizedBox(height: 30),
                      _textField(
                          label: 'Start',
                          hint: 'Choose starting point',
                          prefixIcon: IconButton(
                            icon: Icon(Icons.my_location),
                            onPressed: () {
                              viewModel.startAddressController.text = viewModel.currentAddress;
                              viewModel.startAddress.value = viewModel.currentAddress;
                            },
                          ),
                          // prefixIcon: Icon(Icons.looks_one),
                          textInputAction: TextInputAction.search,
                          suffixIcon: Obx(() => IconButton(
                            icon: Icon(viewModel.ptts11.value ? Icons.mic_off : Icons.mic),
                            onPressed: () {
                              viewModel.startTimer(context);
                              viewModel.valuecheck=1;
                              (viewModel.ptts1)? {
                                print("call mic heree"+viewModel.speechRecognitionAvailable.toString()),
                                print("call mic heree1"+viewModel.isListening.toString()),
                                viewModel.speechRecognitionAvailable && !viewModel.isListening
                                    ?{
                                  //viewModel.ptts11.value=false,
                                  viewModel.onMic(),
                                  print("value of false 1234:"+viewModel.ptts11.value.toString()),
                                  viewModel.ptts1=false, viewModel.start()}
                                    : null}:
                              {
                                //viewModel.ptts11.value=true,
                                viewModel.offMic(),
                                viewModel.ptts1=true,
                                viewModel.speech.cancel(),
                                viewModel.speech.stop()
                              };
                            },
                          )),
                          controller: viewModel.startAddressController,
                          focusNode: viewModel.startAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {
                            //   setState(() {
                            viewModel.startAddress.value = value;
                            // });
                          }


                      ),

                      SizedBox(height: 20),
                      _textField(
                          label: 'Destination',
                          hint: 'Choose destination',
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: ()  {

                              /* if(viewModel.startAddress!='' && viewModel.destinationAddress!=''){
                                    await userController.addUser(
                                      viewModel.startAddress.value,
                                      viewModel.destinationAddress.value,

                                    );
                                  }
*/
                              if(viewModel.startAddress==''){
                                viewModel.startAddressController.text = viewModel.currentAddress;
                                viewModel.startAddress.value =viewModel.currentAddress;
                              }
                              FocusScope.of(context).requestFocus(FocusNode());
                              viewModel.markers.clear();
                              viewModel.polylines.clear();
                              viewModel.polylineCoordinates.clear();
                              viewModel.placeDistance.value = '';


                              /*viewModel.calculateDistance().then((isCalculated) {
                                        if (isCalculated) {
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
                                        }
                                      }*/

                            },
                          ),
                          textInputAction: TextInputAction.search,
                          suffixIcon: Obx(() => IconButton(
                            icon: Icon(viewModel.ptts12.value ? Icons.mic_off : Icons.mic),
                            onPressed: () {
                              viewModel.valuecheck=2;
                              viewModel.startTimer1(context);
                              viewModel.destinationsreach();
                              //viewModel.startTimer1(context);

                              /// check availability
                              /*       (viewModel.ptts2)? {
                                        print("call mic heree"+viewModel.speechRecognitionAvailable.toString()),
                                        print("call mic heree1"+viewModel.isListening.toString()),
                                        (viewModel.speechRecognitionAvailable && !viewModel.isListening)
                                            ?{
                                          //viewModel.ptts11.value=false,
                                          viewModel.onMic2(),
                                          print("value of false 1234:"+viewModel.ptts12.value.toString()),
                                          viewModel.ptts2=false, viewModel.start()}
                                            : null}:
                                      {
                                        //viewModel.ptts11.value=true,
                                        viewModel.offMic2(),
                                        viewModel.ptts2=true,
                                        viewModel.speech.cancel(),
                                        viewModel.speech.stop()
                                      };*/
                            },
                          ),),
                          controller: viewModel.destinationAddressController,
                          focusNode: viewModel.desrinationAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {
                            // setState(() {
                            viewModel.destinationAddress.value = value;
                            // });
                          }),
                      SizedBox(height: 20),
                      /* Obx(()=>
                          viewModel.placeDistance.value == ''?SizedBox()
                              : Text(
                            'DISTANCE:'+ viewModel.placeDistance.value+'km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )

                          ),*/
                      /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Obx(() =>  Radio(

                                    value: 1,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //   setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //   });
                                    },)),
                                  Text('Driving'),
                                  Obx(() =>Radio(

                                    value: 2,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //  setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //  });
                                    },)),
                                  Text('Bicycle'),
                                  Obx(() => Radio(

                                    value: 3,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //   setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //   });
                                    },)),
                                  Text('Walking'),
                                  *//*  Obx(() => Radio(

                              value: 4,
                              groupValue: viewModel.selectedValue.value,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                //   setState(() {
                                viewModel.selectedValue.value = value!;
                                //   });
                              },)),
                            Text('Transit'),*//*
                                ],),*/

                      /*   Visibility(
                            visible: viewModel.placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $viewModel.placeDistance km',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*/


                      // SizedBox(height: 5),
                      /* Container(
                                width: double.infinity,
                                color: AppColor.yellowColor,
                                margin: EdgeInsets.only(top:40,right: 15, left:15,bottom: 40),
                                //margin: EdgeInsets.all(10),
                                child: MaterialButton(
                                  child: Text('Find Directions', style: TextStyle(fontSize: 20.0),),
                                  textColor: Colors.black,
                                  onPressed: () {
                                    print("Caal button"+viewModel.startAddress.value);
                                    print("Caal button12344"+viewModel.destinationAddress.value);
                                    (viewModel.startAddress == '' &&
                                        viewModel.destinationAddress == '')
                                        ?   null : {
                                      print("Caal button1234"),
                                      *//*  late double startLatitude1;
                            late double startLongitude1;
                            late double destinationLatitude1;
                            late double destinationLongitude1;*//*
                                    //  viewModel.openMap(viewModel.startLatitude1,viewModel.startLongitude1,viewModel.destinationLatituate1, viewModel.destinationLongitude1),
                                      //viewModel.openMap(viewModel.st)



                                      *//*  viewModel.startAddressFocusNode.unfocus(),
                              viewModel.desrinationAddressFocusNode.unfocus(),*//*
                                      //      setState(() {
                                      *//*  viewModel.markers.clear(),
                              viewModel.polylines.clear(),
                              viewModel.polylineCoordinates.clear(),
                              viewModel.placeDistance.value = '',*//*
                                      *//* (viewModel.markers.isNotEmpty)
                               ? viewModel.markers.clear():null,
                               (viewModel.polylines.isNotEmpty)
                            ?viewModel.polylines.clear():null,
                               (viewModel.polylineCoordinates.isNotEmpty)?
                            viewModel.polylineCoordinates.clear():null,
                            viewModel.placeDistance.value = '',*//*
                                      // }),

                                      *//*viewModel.calculateDistance().then((isCalculated) {
                                if (isCalculated) {
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
                                }
                              }),*//*
                                    };

                                  },
                                ),

                              ),*/
                      Container(
                          child: GestureDetector(
                            onTap: () async {
                              (viewModel.startAddressController.text == "") ?
                              viewModel.callerrormassage():
                              (viewModel.destinationAddressController.text == "")?viewModel.callerrormassage():
                              viewModel.admob_helper.showInterstitialAd(callback: (){
                                viewModel.performSearch('');
                                //}
                                /*  Get.to(() => NavigationScreenView(),
                                            arguments: {"source": '',"destination": '',"Sourcelath":0.0,"Sourcelog":0.0,"destinationlath":0.0,"destinationlog":0.0});*/

                              });

                              /*(viewModel.startAddressController.text != "" &&
                                        viewModel.destinationAddressController.text != "") ?   viewModel.admob_helper.showInterstitialAd(callback: (){
                                viewModel.performSearch('');
                                //}
                                *//*  Get.to(() => NavigationScreenView(),
                                            arguments: {"source": '',"destination": '',"Sourcelath":0.0,"Sourcelog":0.0,"destinationlath":0.0,"destinationlog":0.0});*//*

                              }): viewModel.callerrormassage();
*/


                            },
                            child:
                            Container(
                              margin: const EdgeInsets.only(top:7,
                                  left: 20.0, right: 20.0),
                              //color: todo_controller.cardBackgroundColor,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                // borderRadius: BorderRadius.circular(15),
                                // Adjust the radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Container(
                                // viewModel.performSearch(query);
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  'Find Directions',
                                  style:
                                  TextStyle(fontSize: 18.0, color: Colors.white),
                                ),
                              ),
                            ),)),

                      /*  ElevatedButton(
                            onPressed: (_startAddress != '' &&
                                _destinationAddress != '')
                                ? () async {
                              startAddressFocusNode.unfocus();
                              desrinationAddressFocusNode.unfocus();
                           //   setState(() {
                                if (markers.isNotEmpty) markers.clear();
                                if (polylines.isNotEmpty)
                                  polylines.clear();
                                if (polylineCoordinates.isNotEmpty)
                                  polylineCoordinates.clear();
                                _placeDistance = null;
                           //   });

                              _calculateDistance().then((isCalculated) {
                                if (isCalculated) {
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
                                }
                              });
                            }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Show Route'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),*/
                    ],
                  ),
                ),
              ),


              ),
/*SizedBox(height: 10,),*/
            Expanded(
              flex: 3,
                child: Container()),
                Expanded(
                  flex: 2,
                  child:
                  Obx(
                        () => Container(
                      height: (!Constent.purchaseads.value)
                          ? 130
                          : 0,
                      width: double.infinity,
                      decoration:   (!Constent.purchaseads.value)
                          ? BoxDecoration(
                        border: Border.all(
                          color: AppColor.borderColor, // Set the color of the border
                          width: 3.0, // Set the width of the border
                        ),
                      )
                          : BoxDecoration(color: Colors.white),
                      child: Material(
                        elevation: 2,
                        child: Obx(
                              () => (Constent.isNativeAdSmallLoaded.value &&
                              viewModel.admob_helper.nativeAdSmall != null &&
                                  !Constent.isOpenAppAdShowing.value
                                  && !Constent.isInterstialAdShowing.value &&
                                  !Constent.purchaseads.value)
                              ? SizedBox(
                            height: 130,
                            width: Get.width,
                            child: AdWidget(ad: viewModel.admob_helper.nativeAdSmall!),
                          )
                              :  !Constent.purchaseads.value
                              ? SmallNativeAdSkeleton()
                              : SizedBox(),
                        ),
                      ),
                    ),
                  )
                ),


                SizedBox(height: 5,),

                  /*Container(

                    margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.primaryColor),// Adjust the radius as needed
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: width * 0.9,
                    child:  Obx(
                          () => Container(
                            margin: EdgeInsets.only(top: 12.0,bottom: 12.0,left: 12.0,right: 12.0),

                        height: (!Constent.purchaseads.value)
                            ? 310
                            : 0,

                        child: Material(
                          elevation: 2,
                          child: Obx(
                                () => (Constent.isNativeAdLoaded.value &&
                                viewModel.admob_helper.nativeAd != null &&
                                     !Constent.isOpenAppAdShowing.value
                                    && !Constent.isInterstialAdShowing.value
                            ) ? SizedBox(
                              height: 310,
                              width: Get.width,
                              child: AdWidget(ad: viewModel.admob_helper.nativeAd!),
                            )

                                    : (!Constent.purchaseads.value )
                                    ? NativeAdSkeleton()
                                    : SizedBox(),
                          ),
                        ),
                      ),
                    )
                  ),*/


              //  ),


               /* SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        width: width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                            *//*  Text(
                                'Navigation',
                                style: TextStyle(fontSize: 20.0),
                              ),*//*
                              SizedBox(height: 10),
                              _textField(
                                  label: 'Start',
                                  hint: 'Choose starting point',
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.my_location),
                                    onPressed: () {
                                      viewModel.startAddressController.text = viewModel.currentAddress;
                                      viewModel.startAddress.value = viewModel.currentAddress;
                                    },
                                  ),
                                  // prefixIcon: Icon(Icons.looks_one),
                                  textInputAction: TextInputAction.search,
                                  suffixIcon: Obx(() => IconButton(
                                    icon: Icon(viewModel.ptts11.value ? Icons.mic_off : Icons.mic),
                                    onPressed: () {
                                      viewModel.startTimer(context);
                                      viewModel.valuecheck=1;
                                      (viewModel.ptts1)? {
                                        print("call mic heree"+viewModel.speechRecognitionAvailable.toString()),
                                        print("call mic heree1"+viewModel.isListening.toString()),
                                        viewModel.speechRecognitionAvailable && !viewModel.isListening
                                            ?{
                                          //viewModel.ptts11.value=false,
                                          viewModel.onMic(),
                                          print("value of false 1234:"+viewModel.ptts11.value.toString()),
                                          viewModel.ptts1=false, viewModel.start()}
                                            : null}:
                                      {
                                        //viewModel.ptts11.value=true,
                                        viewModel.offMic(),
                                        viewModel.ptts1=true,
                                        viewModel.speech.cancel(),
                                        viewModel.speech.stop()
                                      };
                                    },
                                  )),
                                  controller: viewModel.startAddressController,
                                  focusNode: viewModel.startAddressFocusNode,
                                  width: width,
                                  locationCallback: (String value) {
                                    //   setState(() {
                                    viewModel.startAddress.value = value;
                                    // });
                                  }


                              ),

                              SizedBox(height: 10),
                              _textField(
                                  label: 'Destination',
                                  hint: 'Choose destination',
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: ()  {

                                      *//* if(viewModel.startAddress!='' && viewModel.destinationAddress!=''){
                                    await userController.addUser(
                                      viewModel.startAddress.value,
                                      viewModel.destinationAddress.value,

                                    );
                                  }
*//*
                                      if(viewModel.startAddress==''){
                                        viewModel.startAddressController.text = viewModel.currentAddress;
                                        viewModel.startAddress.value =viewModel.currentAddress;
                                      }
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      viewModel.markers.clear();
                                      viewModel.polylines.clear();
                                      viewModel.polylineCoordinates.clear();
                                      viewModel.placeDistance.value = '';


                                      *//*viewModel.calculateDistance().then((isCalculated) {
                                        if (isCalculated) {
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
                                        }
                                      }*//*

                                    },
                                  ),
                                  textInputAction: TextInputAction.search,
                                  suffixIcon: Obx(() => IconButton(
                                    icon: Icon(viewModel.ptts12.value ? Icons.mic_off : Icons.mic),
                                    onPressed: () {
                                      viewModel.valuecheck=2;
                                      viewModel.startTimer1(context);
                                      viewModel.destinationsreach();
                                      //viewModel.startTimer1(context);

                                      /// check availability
                               *//*       (viewModel.ptts2)? {
                                        print("call mic heree"+viewModel.speechRecognitionAvailable.toString()),
                                        print("call mic heree1"+viewModel.isListening.toString()),
                                        (viewModel.speechRecognitionAvailable && !viewModel.isListening)
                                            ?{
                                          //viewModel.ptts11.value=false,
                                          viewModel.onMic2(),
                                          print("value of false 1234:"+viewModel.ptts12.value.toString()),
                                          viewModel.ptts2=false, viewModel.start()}
                                            : null}:
                                      {
                                        //viewModel.ptts11.value=true,
                                        viewModel.offMic2(),
                                        viewModel.ptts2=true,
                                        viewModel.speech.cancel(),
                                        viewModel.speech.stop()
                                      };*//*
                                    },
                                  ),),
                                  controller: viewModel.destinationAddressController,
                                  focusNode: viewModel.desrinationAddressFocusNode,
                                  width: width,
                                  locationCallback: (String value) {
                                    // setState(() {
                                    viewModel.destinationAddress.value = value;
                                    // });
                                  }),
                              SizedBox(height: 10),
                              *//* Obx(()=>
                          viewModel.placeDistance.value == ''?SizedBox()
                              : Text(
                            'DISTANCE:'+ viewModel.placeDistance.value+'km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )

                          ),*//*
                              *//*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Obx(() =>  Radio(

                                    value: 1,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //   setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //   });
                                    },)),
                                  Text('Driving'),
                                  Obx(() =>Radio(

                                    value: 2,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //  setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //  });
                                    },)),
                                  Text('Bicycle'),
                                  Obx(() => Radio(

                                    value: 3,
                                    groupValue: viewModel.selectedValue.value,
                                    activeColor: Colors.green,
                                    onChanged: (value) {
                                      //   setState(() {
                                      viewModel.selectedValue.value = value!;
                                      //   });
                                    },)),
                                  Text('Walking'),
                                  *//**//*  Obx(() => Radio(

                              value: 4,
                              groupValue: viewModel.selectedValue.value,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                //   setState(() {
                                viewModel.selectedValue.value = value!;
                                //   });
                              },)),
                            Text('Transit'),*//**//*
                                ],),*//*

                              *//*   Visibility(
                            visible: viewModel.placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $viewModel.placeDistance km',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),*//*


                              // SizedBox(height: 5),
                             *//* Container(
                                width: double.infinity,
                                color: AppColor.yellowColor,
                                margin: EdgeInsets.only(top:40,right: 15, left:15,bottom: 40),
                                //margin: EdgeInsets.all(10),
                                child: MaterialButton(
                                  child: Text('Find Directions', style: TextStyle(fontSize: 20.0),),
                                  textColor: Colors.black,
                                  onPressed: () {
                                    print("Caal button"+viewModel.startAddress.value);
                                    print("Caal button12344"+viewModel.destinationAddress.value);
                                    (viewModel.startAddress == '' &&
                                        viewModel.destinationAddress == '')
                                        ?   null : {
                                      print("Caal button1234"),
                                      *//**//*  late double startLatitude1;
                            late double startLongitude1;
                            late double destinationLatitude1;
                            late double destinationLongitude1;*//**//*
                                    //  viewModel.openMap(viewModel.startLatitude1,viewModel.startLongitude1,viewModel.destinationLatituate1, viewModel.destinationLongitude1),
                                      //viewModel.openMap(viewModel.st)



                                      *//**//*  viewModel.startAddressFocusNode.unfocus(),
                              viewModel.desrinationAddressFocusNode.unfocus(),*//**//*
                                      //      setState(() {
                                      *//**//*  viewModel.markers.clear(),
                              viewModel.polylines.clear(),
                              viewModel.polylineCoordinates.clear(),
                              viewModel.placeDistance.value = '',*//**//*
                                      *//**//* (viewModel.markers.isNotEmpty)
                               ? viewModel.markers.clear():null,
                               (viewModel.polylines.isNotEmpty)
                            ?viewModel.polylines.clear():null,
                               (viewModel.polylineCoordinates.isNotEmpty)?
                            viewModel.polylineCoordinates.clear():null,
                            viewModel.placeDistance.value = '',*//**//*
                                      // }),

                                      *//**//*viewModel.calculateDistance().then((isCalculated) {
                                if (isCalculated) {
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
                                }
                              }),*//**//*
                                    };

                                  },
                                ),

                              ),*//*
                          Container(
                            child: GestureDetector(
                              onTap: () async {


                                viewModel.performSearch('');

                              },
                              child:
                              Container(
                                margin: const EdgeInsets.only(top:7,
                                    left: 20.0, right: 20.0),
                                //color: todo_controller.cardBackgroundColor,
                                decoration: BoxDecoration(
                                  color: AppColor.yellowColor,
                                 // borderRadius: BorderRadius.circular(15),
                                  // Adjust the radius as needed
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Container(
                                 // viewModel.performSearch(query);
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'Find Directions',
                                    style:
                                    TextStyle(fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),)),

                              *//*  ElevatedButton(
                            onPressed: (_startAddress != '' &&
                                _destinationAddress != '')
                                ? () async {
                              startAddressFocusNode.unfocus();
                              desrinationAddressFocusNode.unfocus();
                           //   setState(() {
                                if (markers.isNotEmpty) markers.clear();
                                if (polylines.isNotEmpty)
                                  polylines.clear();
                                if (polylineCoordinates.isNotEmpty)
                                  polylineCoordinates.clear();
                                _placeDistance = null;
                           //   });

                              _calculateDistance().then((isCalculated) {
                                if (isCalculated) {
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
                                }
                              });
                            }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Show Route'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),*//*
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/
                // Show current location button
                /*SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.green.shade100, // button color
                          child: InkWell(
                            splashColor: AppColor.primaryColor, // inkwell color
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(Icons.arrow_back),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: ClipOval(
                        child: Material(
                          color: Colors.green.shade100, // button color
                          child: InkWell(
                            splashColor: AppColor.primaryColor, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                           *//*   viewModel.mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      viewModel.currentPosition.latitude,
                                      viewModel.currentPosition.longitude,
                                    ),
                                    zoom: 18.0,
                                  ),
                                ),
                              );*//*
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/


           /*     Expanded(
                  flex: 0,
                  child:

                  Container(

                     *//* margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),

                      child: Obx(
                            () => Container(

                          margin: EdgeInsets.symmetric(vertical: 12),
                          color: Colors.white,
                          height: (!Constent.purchaseads.value)
                              ? 310
                              : 0,

                          child: Material(
                            elevation: 2,
                            child: Obx(
                                  () => (Constent.isNativeAdLoaded.value &&
                                  viewModel.admob_helper.nativeAd != null &&
                                  !Constent.isInterstialAdShowing.value &&
                                  !Constent.isOpenAppAdShowing.value &&
                                  !Constent.purchaseads.value
                              ) ? SizedBox(
                                height: 310,
                                width: Get.width,
                                child: AdWidget(ad: viewModel.admob_helper.nativeAd!),
                              )
                                  : (!Constent.purchaseads.value )
                                  ? NativeAdSkeleton()
                                  : SizedBox(),
                            ),
                          ),
                        ),
                      )*//*
                  ),


                ),*/

          /*  Expanded(
              flex: 1,
              child:Container()),*/
              ],
            ),
          ),
        ));
  }
}
