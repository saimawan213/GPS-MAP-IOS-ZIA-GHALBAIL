import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/gdpr/gdpr_helper.dart'
    as gdpr;
import 'package:mapsandnavigationflutter/Screens/MainScreen/MainScreenViewIos.dart';
import 'package:mapsandnavigationflutter/Screens/SplashScreen/SplashViewModel.dart';

class SplashViewIos extends StatefulWidget {
  @override
  State<SplashViewIos> createState() => _SplashViewIosState();
}

class _SplashViewIosState extends State<SplashViewIos> {
  final SplashViewModel viewModel = Get.put(SplashViewModel());

  Future<void> callConsentForm() async {
    try {
      final gdprHelper = gdpr.GeneralDataProtectionRegulationHelper();
      await gdprHelper.requestConsentInfoUpdate();
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callConsentForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  admob_helper.adaptiveloadAd();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //      Center(
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(
                width: 100.0,
                height: 100.0,
                child: Image(
                  image: AssetImage(
                      "assets/images/app_logo.png"), // Replace with the correct asset path
                )
                /*decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage("assets/images/appicon.png")),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.redAccent,
              ),*/
                ),
            /*  Image.asset(
              'assets/images/app_logo.png',
              width: 200,
              height: 200,
            ),*/
          ),
          Expanded(
            flex: 3,
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.location_on,
                    size: 60,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Obx(() => Text(
                      viewModel.currentlocation.value,
                      style: TextStyle(
                          fontSize: 20.0, color: AppColor.primaryColor),
                      textAlign: TextAlign.center,
                    )),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Welcome To \n Maps and Navigation",
                  style:
                      TextStyle(fontSize: 30.0, color: AppColor.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Nearby|GPS Location|WorldClock \n Compass|Geo live Location",
                  style:
                      TextStyle(fontSize: 13.0, color: AppColor.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.center,
                    child: Obx(
                      () => viewModel.showProgressBar.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 40.0, right: 40.0, bottom: 5.0),
                                  child: LinearProgressIndicator(
                                    value: viewModel.progressValue /
                                        100, // Set the value between 0 and 1
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.primaryColor),
                                  ),
                                ),
                                Text('${viewModel.progressValue.toInt()}/100'),
                              ],
                            )
                          : Container(
                              child: GestureDetector(
                                onTap: () async {
                                  /*final String jsonString = await rootBundle.loadString('assets/categories.json');
                            final data = jsonDecode(jsonString);
                            print(data['pois']);
                            List<dynamic> list= data['pois'];
                            for (var i = 0; i < list.length; i++) {
                              // TO DO
                              print("data 123:"+list[i]);

                           //   var currentElement = li[i];
                            }
                            String googleUrl='https://www.google.com/maps/search/?api=1&query=School';
                            if (await canLaunch(googleUrl)) {
                              await launch(googleUrl);
                            } else {
                              throw 'Could not open the map.';
                            }*/

                                  // viewModel.admob_helper.showInterstitialAd(isSplash:true,nextScreen: '/MainScreen_View',  callback: (){});
                                  // throw Exception();
                                  viewModel.admob_helper.showInterstitialAd(
                                      isSplash: true,
                                      callback: () {
                                        Get.off(() => MainScreen_ViewIos());
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 40.0, right: 40.0),
                                  //color: todo_controller.cardBackgroundColor,
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
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
                                      'Lets Go',
                                      style: TextStyle(
                                          fontSize: 22.0, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(),

            /*  Column(
              children: [
                Expanded(
                    flex: 3,
                    child:Container()),
                Expanded(
                    flex: 7,
                    child:Container(

                        margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primaryColor),// Adjust the radius as needed

                        ),
                        child:Obx(()=>
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
                    )))),
              ],
            ),*/
          ),
        ],
      ),
    );
  }
}
