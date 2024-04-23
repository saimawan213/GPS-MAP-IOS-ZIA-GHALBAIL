import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/RouteScreenViewModel.dart';
import 'package:mapsandnavigationflutter/location/domain/usecase/location_permission_usecase.dart';
import 'package:mapsandnavigationflutter/location/domain/usecase/location_service_usecase.dart';
import 'package:mapsandnavigationflutter/location/presentation/popups/location_permission_popup.dart';
import 'package:mapsandnavigationflutter/utils/toast/toast.dart';
import 'package:shimmer/shimmer.dart';

class RouteScreenView extends StatelessWidget {
  final viewModel = Get.put(RouteScreenViewModel());

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

  Future<void> onTapCurrentLocation(BuildContext context) async {
    try {
      final locationPermissionUsecase = LocationPermissionUsecase();
      final locationServicePermission = LocationServicePermissionUsecase();
      await locationPermissionUsecase();
      await locationServicePermission();

      await viewModel.getCurrentLocation();

      viewModel.startAddressController.text = viewModel.currentAddress;
      viewModel.startAddress.value = viewModel.currentAddress;
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

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            const Text('Route Finder', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.yellowColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white, // or MenuOutlined
          onPressed: () {
            Get.back();
            print("call in app ");
          },
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            // Show the place input fields & button for
            // showing the route
            SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
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
                              onPressed: () => onTapCurrentLocation(context),
                            ),
                            textInputAction: TextInputAction.search,
                            suffixIcon: Obx(
                              () => IconButton(
                                icon: Icon(viewModel.ptts11.value
                                    ? Icons.mic_off
                                    : Icons.mic),
                                onPressed: () {
                                  viewModel.startTimer(context);
                                  viewModel.valuecheck = 1;
                                  (viewModel.ptts1)
                                      ? {
                                          print("call mic heree" +
                                              viewModel
                                                  .speechRecognitionAvailable
                                                  .toString()),
                                          print("call mic heree1" +
                                              viewModel.isListening.toString()),
                                          viewModel.speechRecognitionAvailable &&
                                                  !viewModel.isListening
                                              ? {
                                                  //viewModel.ptts11.value=false,
                                                  viewModel.onMic(),
                                                  print("value of false 1234:" +
                                                      viewModel.ptts11.value
                                                          .toString()),
                                                  viewModel.ptts1 = false,
                                                  viewModel.start()
                                                }
                                              : null
                                        }
                                      : {
                                          //viewModel.ptts11.value=true,
                                          viewModel.offMic(),
                                          viewModel.ptts1 = true,
                                          viewModel.speech.cancel(),
                                          viewModel.speech.stop()
                                        };
                                },
                              ),
                            ),
                            controller: viewModel.startAddressController,
                            focusNode: viewModel.startAddressFocusNode,
                            width: width,
                            locationCallback: (String value) {
                              //   setState(() {
                              viewModel.startAddress.value = value;
                              // });
                            },
                          ),
                          SizedBox(height: 20),
                          _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  /* if(viewModel.startAddress!='' && viewModel.destinationAddress!=''){
                                  await userController.addUser(
                                    viewModel.startAddress.value,
                                    viewModel.destinationAddress.value,

                                  );
                                }
                  */
                                  if (viewModel.startAddress == '') {
                                    viewModel.startAddressController.text =
                                        viewModel.currentAddress;
                                    viewModel.startAddress.value =
                                        viewModel.currentAddress;
                                  }
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  viewModel.markers.clear();
                                  viewModel.polylines.clear();
                                  viewModel.polylineCoordinates.clear();
                                  viewModel.placeDistance.value = '';
                                },
                              ),
                              textInputAction: TextInputAction.search,
                              suffixIcon: Obx(
                                () => IconButton(
                                  icon: Icon(viewModel.ptts12.value
                                      ? Icons.mic_off
                                      : Icons.mic),
                                  onPressed: () {
                                    viewModel.valuecheck = 2;
                                    viewModel.startTimer1(context);
                                    viewModel.destinationsreach();
                                  },
                                ),
                              ),
                              controller:
                                  viewModel.destinationAddressController,
                              focusNode: viewModel.desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                // setState(() {
                                viewModel.destinationAddress.value = value;
                                // });
                              }),
                          SizedBox(height: 20),
                          Container(
                            child: GestureDetector(
                              onTap: () async {
                                (viewModel.startAddressController.text == "")
                                    ? viewModel.callerrormassage()
                                    : (viewModel.destinationAddressController
                                                .text ==
                                            "")
                                        ? viewModel.callerrormassage()
                                        : viewModel.admob_helper
                                            .showInterstitialAd(
                                            callback: () {
                                              viewModel.performSearch('');
                                            },
                                          );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 7,
                                  left: 20.0,
                                  right: 20.0,
                                ),
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
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),

            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 1,
              child: Obx(
                () => Container(
                  height: (!Constent.purchaseads.value) ? 70 : 0,
                  width: double.infinity,
                  decoration: (!Constent.purchaseads.value)
                      ? BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                            bottom:
                                BorderSide(color: Color(0xFFD6D6D6), width: 3),
                          ),
                        )
                      : BoxDecoration(color: Color(0xFFe8f0fe)),
                  child: Material(
                    elevation: 2,
                    color: Color(0xFFe8f0fe),
                    child: Obx(
                      () => (viewModel.isBannerAdLoaded.value &&
                              viewModel.bannerAd != null &&
                              !Constent.isOpenAppAdShowing.value &&
                              !Constent.isInterstialAdShowing.value &&
                              !Constent.purchaseads.value)
                          ? SizedBox(
                              height: 50,
                              width: Get.width,
                              child: AdWidget(ad: viewModel.bannerAd!),
                            )
                          : !Constent.purchaseads.value
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
