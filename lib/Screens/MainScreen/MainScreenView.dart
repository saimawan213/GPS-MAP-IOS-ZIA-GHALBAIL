import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/CompassScreen/CompassScreenView.dart';

import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/GeoLiveLocation/GeoLiveLocationView.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/HistoryView.dart';
import 'package:mapsandnavigationflutter/Screens/InAppPurchase/InAppPurchaseViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/MainScreen/CardView.dart';
import 'package:mapsandnavigationflutter/Screens/MainScreen/MainScreenViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/MyLocation/MyLocationView.dart';
import 'package:mapsandnavigationflutter/Screens/NearbyLocation/NearbyLocationView.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/RouteScreenView.dart';
import 'package:mapsandnavigationflutter/Screens/TrafficLight/TrafficLightView.dart';

import 'package:mapsandnavigationflutter/Screens/WorldClockScreen/WorldClockView.dart';

class MainScreen_View extends StatelessWidget {
  MainScreenViewModel viewModel = Get.put(MainScreenViewModel());

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () => viewModel.onWillPopfun(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Maps and Navigation",
              style: TextStyle(color: Colors.white)),
          backgroundColor: AppColor.primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.white, // or MenuOutlined
            onPressed: () {
              print("call in app ");
              // Get.to(() => InApp());
              //  Get.to(/InApp);
              //InApp inAppfile= InApp();
              //viewModel.inAppfile;
              _scaffoldKey.currentState?.openDrawer();
              // Open the drawer here
            },
          ),
          actions: [
            Obx(() => (Constent.purchaseads.value == false)
                ? IconButton(
                    icon: Image.asset(
                      'assets/images/noads.png',
                      height: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //   if(Platform.isAndroid){
                      //     InAppPurchaseViewModel viewModel = Get.put(InAppPurchaseViewModel());
                      //     viewModel.buyLifeTimeSubscription(context);
                      // // Get.to(() => inAppPurchase());
                      //   }
                      /* else{
                  Get.to(() => MyInApp());
                }*/

                      // Handle your icon tap here
                    },
                  )
                : SizedBox()),
          ],
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* Expanded(
                flex: 3,
                child:
                Container(),*/ /* Lottie.asset(
                  'assets/lottie/main.json',
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),*/ /*

              ),*/
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              viewModel.admob_helper.showInterstitialAd(
                                  callback: () {
                                Get.to(() => RouteScreenView());
                                //}
                                /*  Get.to(() => NavigationScreenView(),
                                            arguments: {"source": '',"destination": '',"Sourcelath":0.0,"Sourcelog":0.0,"destinationlath":0.0,"destinationlog":0.0});*/
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/navigate.png', // Replace with your image URL
                                labelText: 'Navigation',
                              ),
                            ),
                          ))),

                          SizedBox(width: 8.0), // Add spacing between cards
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              Get.to(() => NearbyLocationView());
                              /*viewModel.admob_helper.showInterstitialAd(callback: (){

                                      });*/
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/nearbylocation.png', // Replace with your image URL
                                labelText: 'NearByLocation',
                              ),
                            ),
                          ))),
                          SizedBox(width: 8.0), // Add spacing between cards

                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              viewModel.admob_helper.showInterstitialAd(
                                  callback: () {
                                Get.to(() => MyLocationView());
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/mylocation.png', // Replace with your image URL
                                labelText: 'My Location',
                              ),
                            ),
                          ))),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              Get.to(() => WorldClockView());
                              /*viewModel.admob_helper.showInterstitialAd(callback: (){

                                      });*/
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/worldclock.png', // Replace with your image URL
                                labelText: 'World Clock',
                              ),
                            ),
                          ))),

                          SizedBox(width: 8.0), // Add spacing between cards
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              viewModel.admob_helper.showInterstitialAd(
                                  callback: () {
                                Get.to(() => TrafficLightView());
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/trafficlight.png', // Replace with your image URL
                                labelText: 'Traffic Light',
                              ),
                            ),
                          ))),
                          SizedBox(width: 8.0), // Add spacing between cards

                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              Get.to(() => HistoryView());
                              /* viewModel.admob_helper.showInterstitialAd(callback: (){

                                      });*/
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/history.png', // Replace with your image URL
                                labelText: 'History',
                              ),
                            ),
                          ))),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              Get.to(() => CompassScreenView());
                              /* viewModel.admob_helper.showInterstitialAd(callback: (){

                                      });
*/
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/compass.png', // Replace with your image URL
                                labelText: 'Compass',
                              ),
                            ),
                          ))),

                          SizedBox(width: 8.0), // Add spacing between cards
                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              Get.to(() => GeoLiveLocationView());
                              /*viewModel.admob_helper.showInterstitialAd(callback: (){
                                        Get.to(() => GeoLiveLocationView());
                                      });*/
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/geolivelocation.png', // Replace with your image URL
                                labelText: 'Geolive Location',
                              ),
                            ),
                          ))),
                          SizedBox(width: 8.0), // Add spacing between cards

                          Expanded(
                              child: Container(
                                  child: GestureDetector(
                            onTap: () {
                              viewModel.shareApp();
                              /*viewModel.admob_helper.showInterstitialAd(callback: (){
                                      });*/

                              //Get.to(() => HistoryView());
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: CardView(
                                imageUrl:
                                    'assets/images/share.png', // Replace with your image URL
                                labelText: 'Share',
                              ),
                            ),
                          ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              /*     Expanded(
                flex: 2,
                child:    Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),


                    SizedBox(width: 8.0), // Add spacing between cards
                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),
                    SizedBox(width: 8.0), // Add spacing between cards

                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),

                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:    Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),


                    SizedBox(width: 8.0), // Add spacing between cards
                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),
                    SizedBox(width: 8.0), // Add spacing between cards

                    Expanded(
                        child: Container(
                            child: GestureDetector(

                              onTap: () {
                                Get.to(() => HistoryView());


                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: CardView(
                                  imageUrl: 'https://example.com/image1.jpg', // Replace with your image URL
                                  labelText: 'Navigation',
                                ),
                              ),
                            ))),

                  ],
                ),
              ),*/
              /* Expanded(
                flex: 2,
                child: Container(

                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                  child: GestureDetector(

                                    onTap: () {

                                      // viewModel.admob_helper.showInterstitialAd();

                                      //   todo_controller.falutname="C";
                                      // Get.to(() => UBCfaultScreen());
                                     */ /* viewModel.admob_helper.showInterstitialAd(nextScreen:'/ImagesShowView',callback: (){
                                        // write code here
                                      });*/ /*
                                        Get.to(() => WorldClockView());
                                    },

                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      //color: todo_controller.cardBackgroundColor,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  margin: const EdgeInsets.all(5),



                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: const Icon(Icons.save,size: 50,color: Colors.white,),

                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              // alignment:Alignment.center,
                                              //  child: const Text('Saved Docs'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),


                            ),
                            Expanded(
                                flex: 2,
                                child:   const Text('World Clock',style: TextStyle(fontSize: 20),))
                          ],
                        ),




                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: GestureDetector(

                            onTap: () {



                                // viewModel.admob_helper.showInterstitialAd();

                                //   todo_controller.falutname="C";
                                // Get.to(() => UBCfaultScreen());
                                */ /* viewModel.admob_helper.showInterstitialAd(nextScreen:'/ImagesShowView',callback: (){
                                        // write code here
                                      });*/ /*
                               Get.to(() => HistoryView());

                              // viewModel.admob_helper.showInterstitialAd();
                              // viewModel.admob_helper.showInterstitialAd();

                              //    Restart.restartApp();
                              // todo_controller.falutname="U";
                          */ /*    viewModel.admob_helper.showInterstitialAd(nextScreen:'/AboutUS',callback: (){
                                // write code here
                              });*/ /*
                              // Get.to(() => AboutScreen());

                            },
                            child:Column(
                              children: [
                                Expanded(
                                    flex: 8,
                                    child:
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      //color: todo_controller.cardBackgroundColor,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(

                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  margin: const EdgeInsets.all(5),



                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: const Icon(Icons.info,size: 50,color: Colors.white,),
                                              // child: const Icon(Icons.star),


                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  alignment:Alignment.center,
                                              //   child: const Text('Rate Us'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child:   const Text('History',style: TextStyle(fontSize: 20),))
                              ],
                            ),


                          ),
                        ),
                      ),

                    ],
                  ),


                ),
              ),
              Expanded(
                flex: 2,
                child: Container(

                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                  child: GestureDetector(

                                    onTap: () {

                                      // viewModel.admob_helper.showInterstitialAd();

                                      //   todo_controller.falutname="C";
                                      // Get.to(() => UBCfaultScreen());
                                      */ /* viewModel.admob_helper.showInterstitialAd(nextScreen:'/ImagesShowView',callback: (){
                                        // write code here
                                      });*/ /*
                                      Get.to(() => WorldClockView());
                                    },

                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      //color: todo_controller.cardBackgroundColor,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  margin: const EdgeInsets.all(5),



                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: const Icon(Icons.save,size: 50,color: Colors.white,),

                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              // alignment:Alignment.center,
                                              //  child: const Text('Saved Docs'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),


                            ),
                            Expanded(
                                flex: 2,
                                child:   const Text('World Clock',style: TextStyle(fontSize: 20),))
                          ],
                        ),




                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: GestureDetector(

                            onTap: () {



                              // viewModel.admob_helper.showInterstitialAd();

                              //   todo_controller.falutname="C";
                              // Get.to(() => UBCfaultScreen());
                              */ /* viewModel.admob_helper.showInterstitialAd(nextScreen:'/ImagesShowView',callback: (){
                                        // write code here
                                      });*/ /*
                              Get.to(() => HistoryView());

                              // viewModel.admob_helper.showInterstitialAd();
                              // viewModel.admob_helper.showInterstitialAd();

                              //    Restart.restartApp();
                              // todo_controller.falutname="U";
                              */ /*    viewModel.admob_helper.showInterstitialAd(nextScreen:'/AboutUS',callback: (){
                                // write code here
                              });*/ /*
                              // Get.to(() => AboutScreen());

                            },
                            child:Column(
                              children: [
                                Expanded(
                                    flex: 8,
                                    child:
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      //color: todo_controller.cardBackgroundColor,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(

                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  margin: const EdgeInsets.all(5),



                                            ),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: const Icon(Icons.info,size: 50,color: Colors.white,),
                                              // child: const Icon(Icons.star),


                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              //  alignment:Alignment.center,
                                              //   child: const Text('Rate Us'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child:   const Text('History',style: TextStyle(fontSize: 20),))
                              ],
                            ),


                          ),
                        ),
                      ),

                    ],
                  ),


                ),
              ),*/
              /* Expanded(
                flex: 1,
                child: Container(

                ),
              ),*/
              /*const Expanded(
              flex: 1,
              child: Text("Fault Codes",style: TextStyle(color: Colors.white)),

            ),*/
              Expanded(
                  flex: 2,
                  child:
                      Container() /*Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child:Container()),
                    Expanded(
                        flex: 7,
                        child:  Obx(()=>
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
                        ):SizedBox()

                        )),
                  ],
                ),*/

                  ),
            ],
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColor.primaryColor),
                accountName: Text("Maps and Navigation"),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/app_logo.png"),
                  //child: Image.asset('assets/images/share.png'),
                ),
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(' Home '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(' History '),
                onTap: () {
                  Get.to(() => HistoryView());
                  //Navigator.pop(context);
                  /* viewModel.admob_helper.showInterstitialAd(nextScreen: 'no',callback: (){
                    // write code here
                    viewModel.openImageCamera(context);});*/
                  // Get.to(() => ImagesShowView());
                  //  Navigator.pop(context);

                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text(' Share App '),
                onTap: () {
                  viewModel.shareApp();
                  Navigator.pop(context);
                  /*    viewModel.admob_helper.showInterstitialAd(nextScreen: 'no',  callback: (){
                    // write code here
                    viewModel.openImageGallery(context);});*/
                  //  viewModel.openImageGallery(context);
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text(' Rate Us '),
                onTap: () {
                  viewModel.openPlayStore();
                  Navigator.pop(context);
                  /*   viewModel.admob_helper.showInterstitialAd(nextScreen:'/ImagesShowView',callback: (){
                    // write code here
                  });*/
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text(' Exit '),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.onWillPopfun(context);
                  /* viewModel.admob_helper.showInterstitialAd(nextScreen:'/AboutUS',callback: (){
                    // write code here
                  });*/
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ), //Drawer
      ),
    );
  }
}
