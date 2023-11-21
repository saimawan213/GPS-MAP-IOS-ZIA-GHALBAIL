import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/MyLocation/MyLocationViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/NavigationScreen/NavigationScreenViewModel.dart';




class MyLocationView extends StatelessWidget {
  MyLocationViewModel  viewModel = Get.put(MyLocationViewModel());

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required TextInputAction textInputAction,
    required Icon prefixIcon,
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
          viewModel.performSearch(query);
        },*/
        controller: controller,
        focusNode: focusNode,
        enabled: false,
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Obx(()=>
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
            )),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.green.shade100, // button color
                        child: InkWell(
                          splashColor:AppColor.primaryColor, // inkwell color
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
            ),
            // Show the place input fields & button for
            // showing the route
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
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
                          Text(
                            'My Location',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Start',
                              hint: 'Choose starting point',
                              prefixIcon: Icon(Icons.looks_one),
                              textInputAction: TextInputAction.search,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  viewModel.startAddressController.text = viewModel.currentAddress;
                                  viewModel.startAddress.value = viewModel.currentAddress;
                                },
                              ),
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
                        /*  _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon: Icon(Icons.looks_two),
                              textInputAction: TextInputAction.search,
                              suffixIcon: IconButton(
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


                                  viewModel.calculateDistance().then((isCalculated) {
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
                                },
                              ),
                              controller: viewModel.destinationAddressController,
                              focusNode: viewModel.desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                // setState(() {
                                viewModel.destinationAddress.value = value;
                                // });
                              }),*/
                          SizedBox(height: 10),
                 /*         Obx(()=>
                          viewModel.placeDistance.value == ''?SizedBox()
                              : Text(
                            'DISTANCE:'+ viewModel.placeDistance.value+'km',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )

                          ),*/
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
                    /*      Container(
                            margin: EdgeInsets.all(25),
                            child: MaterialButton(
                              child: Text('Navigation', style: TextStyle(fontSize: 20.0),),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
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
                                  NavigationScreenViewModel.openMap(viewModel.startLatitude1,viewModel.startLongitude1,viewModel.destinationLatituate1, viewModel.destinationLongitude1),
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
              ),
            ),
            SafeArea(
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
            // Show current location button
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
                          viewModel.mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  viewModel.currentPosition.latitude,
                                  viewModel.currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
