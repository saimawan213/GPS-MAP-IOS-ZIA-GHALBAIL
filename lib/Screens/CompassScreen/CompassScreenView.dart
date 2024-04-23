import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/CompassScreen/CompassScreenViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/location/domain/usecase/location_permission_usecase.dart';
import 'package:mapsandnavigationflutter/location/domain/usecase/location_service_usecase.dart';
import 'package:mapsandnavigationflutter/location/presentation/popups/location_permission_popup.dart';
import 'package:mapsandnavigationflutter/utils/toast/toast.dart';
import 'package:shimmer/shimmer.dart';

class CompassScreenView extends StatelessWidget {
  CompassScreenViewModel viewModel = Get.put(CompassScreenViewModel());

  Future<void> checkLocationPermission() async {
    final locationPermissionUsecase = LocationPermissionUsecase();
    final locationServicePermission = LocationServicePermissionUsecase();
    await locationPermissionUsecase();
    await locationServicePermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Compass'),
          backgroundColor: AppColor.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white, // or MenuOutlined
            onPressed: () {
              Navigator.pop(context);
              print("call in app ");
            },
          ),
        ),
        body: Builder(
          builder: (context) {
            return FutureBuilder(
              future: checkLocationPermission(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.error is PermissionPermanentlyDenied ||
                    snapshot.error is PermissionDenied ||
                    snapshot.error is LocationServiceDisabledException) {
                  return retryButton(context);
                } else {
                  return Obx(
                    () => viewModel.hasPermissions.value
                        ? Builder(builder: (context) {
                            return Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Column(
                                children: <Widget>[
                                  // _buildManualReader(),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Compass Direction and Degree:',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Obx(
                                          () => Text(
                                            viewModel.compassDirection.value +
                                                "\t\t\t" +
                                                viewModel.compassvalue.value
                                                    .toStringAsFixed(0) +
                                                "\u00B0",
                                            style: TextStyle(
                                                fontSize: 48,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(child: _buildCompass()),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(flex: 4, child: Container()),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFe8f0fe),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border(
                                                top: BorderSide(
                                                    color: Color(0xFFD6D6D6),
                                                    width: 3),
                                                bottom: BorderSide(
                                                    color: Color(0xFFD6D6D6),
                                                    width: 3),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: Obx(
                                                () => (viewModel
                                                            .admob_helper
                                                            .isBannerLoaded
                                                            .value &&
                                                        !Constent
                                                            .isOpenAppAdShowing
                                                            .value &&
                                                        !Constent
                                                            .isInterstialAdShowing
                                                            .value &&
                                                        !Constent.adspurchase)
                                                    ? Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: SafeArea(
                                                          child: SizedBox(
                                                            width: viewModel
                                                                .admob_helper
                                                                .anchoredAdaptiveAd!
                                                                .size
                                                                .width
                                                                .toDouble(),
                                                            height: viewModel
                                                                .admob_helper
                                                                .anchoredAdaptiveAd!
                                                                .size
                                                                .height
                                                                .toDouble(),
                                                            child: AdWidget(
                                                                ad: viewModel
                                                                    .admob_helper
                                                                    .anchoredAdaptiveAd!),
                                                          ),
                                                        ),
                                                      )
                                                    : (!Constent.adspurchase)
                                                        ? SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height: 30,
                                                            child: Shimmer
                                                                .fromColors(
                                                              baseColor: Colors
                                                                  .grey[300]!,
                                                              highlightColor:
                                                                  Colors.white,
                                                              child: Container(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                        : SizedBox(),
                  );
                }
              },
            );
          },
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
        print('direction is:' + direction.toString());
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

  Widget retryButton(BuildContext context) {
    Future<void> onTapRetry(BuildContext context) async {
      try {
        final locationPermissionUsecase = LocationPermissionUsecase();
        final locationServicePermission = LocationServicePermissionUsecase();
        await locationPermissionUsecase();
        await locationServicePermission();
        await viewModel.requestPermission();
      } on PermissionDenied catch (_) {
        showToast(msg: "Location permission denied");
      } on PermissionPermanentlyDenied catch (_) {
        await showDialog(
          context: context,
          builder: (context) => LocationPermissionPopup(),
        );
      } on LocationServiceDisabledException catch (_) {
        showToast(msg: "Enable location service");
      }
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location Permission Required.'),
          ElevatedButton(
            child: Text('Retry'),
            onPressed: () => onTapRetry(context),
          ),
        ],
      ),
    );
  }
}
