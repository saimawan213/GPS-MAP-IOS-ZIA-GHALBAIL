import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/WorldClockScreen/WorldClockViewModel.dart';
import 'package:shimmer/shimmer.dart';

class WorldClockView extends StatelessWidget {
  //final db = Localstore.instance;
  WorldClockViewModel viewModel = Get.put(WorldClockViewModel());

  @override
  Widget build(BuildContext context) {
    // viewModel.data =
    //viewModel.data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : viewModel.data;
    //String bgImage = "";
    // set background
    /*  setState(() {
      bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';
    });
*/
    return Scaffold(
      appBar: appBar(),
    //  bottomNavigationBar: bannerAd(),
      body:Center(
        child: Obx(
                () =>(viewModel.data.value.isEmpty)?CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.yellowColor), // Set color here
    ):


        Column(
          children: [
            locationBtn(context),
            firstContainer(context),
            secondContainer(),

            bannerAd(),
            SizedBox(height: 5),
            // bannerAd(),
          ],
        )),
      ),
    );
  }

  Expanded firstContainer(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
          margin:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.primaryColor,
              // You can set the border color here.
              width: 2.0, // You can set the border width here.
            ),
            color: Colors.white,
            // Set the background color of the container
            borderRadius: BorderRadius.circular(16.0),
            // Set the corner radius
            boxShadow: [
              BoxShadow(
                color: Colors.grey, // Set the shadow color
                offset: Offset(0, 2), // Set the shadow offset
                blurRadius: 4.0, // Set the blur radius
                spreadRadius: 0, // Set the spread radius
              ),
            ],
          ),
          child: Obx(
                () => (viewModel.checknet.value)
                ? Refrshindicatorwodge(context)
                : SizedBox(
              width: double.infinity,
            ),
            /* Constent.showNoConnectionDialog(context).then((data) async {
         // await setupWorldTime();
        }),*/
          )
      ),
    );
  }
  Expanded secondContainer() {
    return Expanded(
      flex: 4,
      child: Container(
        margin:
        EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.primaryColor,
            // You can set the border color here.
            width: 2.0, // You can set the border width here.
          ),
          color: Colors.white,
          // Set the background color of the container
          borderRadius: BorderRadius.circular(16.0),
          // Set the corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Set the shadow color
              offset: Offset(0, 2), // Set the shadow offset
              blurRadius: 4.0, // Set the blur radius
              spreadRadius: 0, // Set the spread radius
            ),
          ],
        ),
        child: Obx(
              () => Column(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/sunrise.png"), // Replace with the correct asset path
                            )

                        ),
                        /*Image(
                          image: AssetImage("assets/images/sunrise.png"), // Replace with the correct asset path
                        ),*/
                        Text("Sunrise"),
                        Text(viewModel.Sunrise.value),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/sunset.png"), // Replace with the correct asset path
                            )

                        ),
                        Text("Sunset"),
                        Text(viewModel.Sunset.value),
                      ],
                    ),
                    Column(
                      children: [

                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/windspeed.png"), // Replace with the correct asset path
                            )

                        ),
                        Text("Wind Speed"),
                        Text(viewModel.windSpeed.value+"m/s"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/pressure.png"), // Replace with the correct asset path
                            )

                        ),
                        Text("Pressure"),
                        Text(viewModel.pressure.value+"hPa"),
                      ],
                    ),
                    Column(
                      children: [

                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/humidity.png"), // Replace with the correct asset path
                            )

                        ),
                        Text("Humidity"),
                        Text(viewModel.humidity.value+"%"),
                      ],
                    ),
                    Column(
                      children: [

                        Container(
                            width: 50.0,
                            height: 50.0,
                            child: Image(
                              image: AssetImage("assets/images/clouds.png"), // Replace with the correct asset path
                            )

                        ),
                        Text("clouds"),
                        Text(viewModel.clouds.value+"%"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerAd() {
    return  Expanded(
      flex: 2,
      child:  Column(
        children: [
          Expanded(
              flex: 4,
              child:Container()),
          Expanded(
              flex: 6,
              child: Container(

                  margin: EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    border: Border(
                      top: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                      bottom: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                      // You can remove the left and right borders by commenting them out
                      // left: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                      // right: BorderSide(color: Color(0xFFD6D6D6), width: 3),
                    ),
                    //border: Border.all(color: AppColor.borderColor,width: 3),// Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),child:Container(
                  margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
                  child: Obx(()=>
                  (viewModel.admob_helper.isBannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value && !Constent.adspurchase)?
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: SizedBox(
                        width:viewModel.admob_helper.anchoredAdaptiveAd!.size.width.toDouble(),
                        height:viewModel.admob_helper.anchoredAdaptiveAd!.size.height.toDouble(),
                        child: AdWidget(ad: viewModel.admob_helper.anchoredAdaptiveAd!),
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
                  )))),
        ],
      ),
    );
  }

  Widget locationBtn(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextButton.icon(
          onPressed: () async {
            dynamic result = await Navigator.pushNamed(context, "/location",
                arguments: Constent.getCountriesList());
            //  final prefs = await SharedPreferences.getInstance();
            // prefs.setString("location", result["location"]);
            //  prefs.setString("url", result["url"]);
            if (result != null) {
              //   setState(() {
              print('********************************');
              print(result);
              viewModel.data.value = result;
              if (result['weatherData']['cod'] == 200) {
               // viewModel.data.value = result;
                viewModel.setData(result['weatherData']);
              } else {
                viewModel.data['weatherData'] = null;
                print('no record found');
                viewModel.resetData();
              }
              //  });
            }
          },
          icon: Icon(
            Icons.edit_location,
            color: Colors.black,
            //color: Colors.grey[300],
          ),
          label: Text(
            'Change Location',
            style: TextStyle(color: Colors.black, letterSpacing: 2),
          )),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('World Clock', style: TextStyle(color: Colors.white)),
      backgroundColor: AppColor.primaryColor,
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
    );
  }

  Widget Refrshindicatorwodge(BuildContext context) {
    return Obx(() => (viewModel.data.length == 0)
        ?
    // await setupWorldTime();
    /* Constent.showNoConnectionDialog(context).then((data) async {
      // await setupWorldTime();
    })*/

    SizedBox(width: double.infinity)
        : Container(
      width: double.infinity,
      // decoration: BoxDecoration(
      // image: DecorationImage(
      //     image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
      child: Column(children: <Widget>[
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.data["location"],
                style: TextStyle(
                    fontSize: 28, letterSpacing: 2, color: Colors.black)),
          ],
        ),
        SizedBox(height: 20),
        Text(
          viewModel.data['time'],
          style: TextStyle(fontSize: 35, color: Colors.black),
        ),
        SizedBox(height: 20),
        Text(
            "${viewModel.data['weatherData'] != null ? (viewModel.data["weatherData"]['main']['temp'].round()) : ''}° ${viewModel.data['weatherData'] != null ? viewModel.data["weatherData"]['weather'][0]['description'] : ''}",
            style: TextStyle(
                fontSize: 20, letterSpacing: 2, color: Colors.black))
        // WeatherWidget(
        //   weatherData: viewModel.data["weatherData"],
        // ),
      ]),
    ));
    // return RefreshIndicator(
    //   onRefresh: () async {
    //     print("datalocation::" + viewModel.data["location"]);
    //     print("dataurl::" + viewModel.data["url"]);
    //     Constent instance = Constent(
    //         location: viewModel.data["location"], url: viewModel.data["url"]);
    //     if (await Constent.checkIntenetConnection()) {
    //       await instance.getTime();
    //       await instance.getWeather();
    //       //  setState(() {
    //       viewModel.data["location"] = instance.location;
    //       viewModel.data["time"] = instance.time;
    //       viewModel.data["isDaytime"] = instance.isDaytime;
    //       viewModel.data["weatherData"] = instance.weatherData;
    //       // });
    //     } else {
    //       Constent.showNoConnectionDialog(context);
    //     }
    //   },
    //   child: ,
    // );
  }
}