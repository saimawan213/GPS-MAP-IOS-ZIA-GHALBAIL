import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/GeoLiveLocation/GeoLiveLocationViewModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class GeoLiveLocationView extends StatelessWidget {
  GeoLiveLocationViewModel  viewModel = Get.put(GeoLiveLocationViewModel());

  final _scaffoldKey = GlobalKey<ScaffoldState>();

 /* Widget _textField({
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
        onSubmitted: (String query) {
      //    viewModel.performSearch(query);
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
*/
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
        appBar: AppBar(
          title: const Text("Geo live Location",style: TextStyle(color: Colors.white)),
          backgroundColor: AppColor.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
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
          actions: [
            Obx(()=>
            (viewModel.imageFile.value.path.isNotEmpty)?
            IconButton(
              icon:const Icon(Icons.share,color: Colors.white,)
              ,

              onPressed: () async {
                final bytes = await viewModel.controller.capture();

                viewModel.bytes = bytes;
                File file=File.fromRawPath(bytes!);
                print('path is heree:'+ File.fromRawPath(bytes!).toString());

                final tempDir = await getTemporaryDirectory();
                File file1 = await File('${tempDir.path}/image.png').create();
                file1.writeAsBytesSync(bytes);
                // store unit8list image here ;
                // String s = new String.fromCharCodes(bytes!);
                await Share.shareFiles([file1.path]);
              },
            ):SizedBox(),),
           ],


        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child:WidgetsToImage(
                controller: viewModel.controller,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    Container(

                      child:  Obx(()=>
                  (viewModel.imageFile.value.path.isNotEmpty)?Image.file(viewModel.imageFile.value): Container(
                    width: double.infinity,
                    height: 60,
                    child: GestureDetector(
                      onTap: () async {
                        viewModel.imgFromCamera();

                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        //color: todo_controller.cardBackgroundColor,
                        decoration: BoxDecoration(
                          color: AppColor.yellowColor,
                          borderRadius: BorderRadius.circular(15),
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
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Capture Image from Image',
                            style:
                            TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),),
                    ),
      Obx(()=>
      (viewModel.imageFile.value.path.isNotEmpty)?Positioned(
        bottom: 100, // Align to the bottom of the Stack
        left: 10, // Align to the left of the Stack
        right: 10,

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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Obx(()=>  Text(
                    viewModel.currentAddress.value,
                    style: TextStyle(fontSize: 20.0,color: AppColor.primaryColor),
                  ),
                  ),
                  Obx(()=>  Text("Date :"+
                      viewModel.actualDate.value,
                    // textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20.0,color: AppColor.primaryColor),
                  ),
                  ),
                  Obx(()=>  Text("Time :"+
                      viewModel.actualTime.value,
                    // textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20.0,color: AppColor.primaryColor),
                  ),
                  ),

                  SizedBox(height: 10),

                  // SizedBox(height: 5),
                  /* Container(
                                  margin: EdgeInsets.all(25),
                                  child: MaterialButton(
                                    child: Text('Share', style: TextStyle(fontSize: 20.0),),
                                    color: AppColor.primaryColor,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      // Image.file(viewModel.image.);
                                      final bytes = await viewModel.controller.capture();

                                      viewModel.bytes = bytes;
                                      File file=File.fromRawPath(bytes!);
                                      print('path is heree:'+ File.fromRawPath(bytes!).toString());

                                      final tempDir = await getTemporaryDirectory();
                                      File file1 = await File('${tempDir.path}/image.png').create();
                                      file1.writeAsBytesSync(bytes);
                                      // store unit8list image here ;
                                      // String s = new String.fromCharCodes(bytes!);
                                      await Share.shareFiles([file1.path]);
                                      // print('image path '+bytes.toString());
                                      //  if (bytes != null) buildImage(bytes!);



                                    },
                                  ),

                                ),*/

                ],
              ),
            ),
          ),
        ),
      ):
          SizedBox(),

                 )
                    // Show current location button

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container() /*Column(
                children: [
                  Expanded(
                      flex: 3,
                      child:Container()),
                  Expanded(
                      flex: 7,
                      child:  Obx(()=>
                           (viewModel.imageFile.value.path.isNotEmpty)?
                      (viewModel.admob_helper.issmallBannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value && !Constent.adspurchase)?
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
                          :(!Constent.adspurchase)?

                      SizedBox(
                          width:double.infinity,
                          height: 30,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white,
                            child: Container(
                              color: Colors.grey,
                            ),
                          )
                      ):SizedBox():SizedBox())),
                ],
              ),*/

            ),

          ],
        ),
      ),
    );
  }
  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
}
