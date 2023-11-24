import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/CompassScreen/CompassScreenViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';

import 'package:shimmer/shimmer.dart';




class CompassScreenView extends StatelessWidget {

  CompassScreenViewModel  viewModel = Get.put(CompassScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Compass'),
          backgroundColor: AppColor.yellowColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,// or MenuOutlined
            onPressed: () {
              Navigator.pop(context);
              print("call in app ");
              // Get.to(() => InApp());
              //  Get.to(/InApp);
              //InApp inAppfile= InApp();
              //viewModel.inAppfile;
              // Open the drawer here
            },
          ),
        ),
        body: Obx(()=>
        viewModel.hasPermissions.value ?
            Builder(builder: (context) {
             // if (viewModel.hasPermissions.value) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    /*   borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],*/
                  ),
                  child: Column(
                    children: <Widget>[
                     // _buildManualReader(),
                    Expanded(
                    flex: 1,
                    child: Container(),
                    ),
                  Expanded(
                    flex: 7,
                      child:Column(
                        children: [
                          Text(
                            'Compass Direction and Degree:',
                            style: TextStyle(fontSize: 18),
                          ),
                    Obx(() =>   Text(
                      viewModel.compassDirection.value +"\t\t\t" +viewModel.compassvalue.value.toStringAsFixed(0)+ "\u00B0",
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),

                    ),),
                          Expanded(child: _buildCompass()),
                        ],
                      ),
                   /* Obx(() =>   Text(
                      viewModel.compassDirection.value +"\t\t\t" +viewModel.compassvalue.value.substring(0,viewModel.compassvalue.value.indexOf('.'))+ "\u00B0",
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),),*/
                   ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                child:Container()),
                            Expanded(
                                flex: 7,
                                child:  Obx(()=>
                                (viewModel.admob_helper.issmallBannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value)?
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SafeArea(
                                    child: SizedBox(
                                      width:viewModel.admob_helper.bannerAd!.size.width.toDouble(),
                                      height:viewModel.admob_helper.bannerAd!.size.height.toDouble(),
                                      child: AdWidget(ad: viewModel.admob_helper.bannerAd!),
                                    ),
                                  ),
                                )
                                    :SizedBox(
                                    width:double.infinity,
                                    height: 30,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    )
                                ))),
                          ],
                        ),

                      ),



                   /*   Obx(() =>  Text(
                        viewModel.compassvalue.value.substring(0,viewModel.compassvalue.value.indexOf('.')),
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),),*/

                    ],
                  ),
                );
           /*   } else {
                return _buildPermissionSheet();
              }*/
            }) :
       SizedBox(),

        ),
      ),
    );
  }

  Widget _buildManualReader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          ElevatedButton(
            child: Text('Read Value'),
            onPressed: () async {
              final CompassEvent tmp = await FlutterCompass.events!.first;
             /* setState(() {
                _lastRead = tmp;
                _lastReadAt = DateTime.now();
              });*/
            },
          ),
        /*  Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                   // '$_lastRead',
                   // style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                   // '$_lastReadAt',
                   // style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;
        print('direction is:'+direction.toString());
        /* setState(() {
          compassDirection = _getCompassDirection(snapshot.data!.heading);
        });*/

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        return Material(
        /*  shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,*/
          child: Container(

            padding: EdgeInsets.all(50.0),
            decoration: const BoxDecoration(
              color: Colors.white,
           /*   borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],*/
            ),
            alignment: Alignment.center,
          /*  decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),*/
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Image.asset('assets/images/compassicon1.png'),
            ),
          ),
        );
      },
    );
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
/*  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location Permission Required'),
          ElevatedButton(
            child: Text('Request Permissions'),
            onPressed: () {
              Permission.locationWhenInUse.request().then((ignored) {
                viewModel.fetchPermissionStatus();
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Open App Settings'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }*/

/*  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }*/
}
