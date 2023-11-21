import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';

import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/WorldClockScreen/SelectLocationViewModel.dart';
import 'package:shimmer/shimmer.dart';



class SelectlcoationView extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<SelectlcoationView> {
  TextEditingController editingController = TextEditingController();
  SelectLocationViewModel  viewModel = Get.put(SelectLocationViewModel());
  var _future;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    _future = Constent.getCountriesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: Text("Choose a location", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          elevation: 0,  leading: IconButton(
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
        body: Column(
          children: [
          Expanded(
          flex: 10,
          child:
          Column(
              children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    fillColor: Colors.grey[100],
                    filled: true,
                  hintStyle: const TextStyle(
                      color: AppColor.primaryColor
                  ),
                  labelStyle: const TextStyle(
                      color: AppColor.primaryColor
                  ),
                    prefixIcon: Icon(Icons.search),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),

                  focusedBorder:const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))

                  ),
             /*   const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))
                ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))
                    focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryColor, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(25.0))

              ),*/),
              ),
            ),

            FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index].url
                            .toString()
                            .toLowerCase()
                            .contains(searchString)
                            ?  Container(
                            margin: const EdgeInsets.only(top: 7.0,right: 30.0,left: 30.0,bottom: 0.0),
                            //color: todo_controller.cardBackgroundColor,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 4),
                              child: ListTile(
                                onTap: () async {
                                  await snapshot.data[index].getTime();
                                  await snapshot.data[index].getWeather();
                                  // the same thing as what the arrow do: Pop:
                                  Navigator.pop(context, {
                                    "location": snapshot.data[index].location,
                                    //flag": snapshot.data[index].flag,
                                    "time": snapshot.data[index].time,
                                    "isDaytime":
                                    snapshot.data[index].isDaytime,
                                    "url": snapshot.data[index].url,
                                    "weatherData":
                                    snapshot.data[index].weatherData
                                  });
                                },
                                title: Text(
                                    snapshot.data[index].url.toString(), style: TextStyle(color: Colors.white)),
                                //leading: CircleAvatar(backgroundImage: AssetImage('assets/${ snapshot.data[index].flag}'),),
                              ),
                            ))
                            : Container();
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: Check your Network Connection!'),
                          )
                        ]),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child:CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor), // Set color here
                            ),
                            //CircularProgressIndicator(),
                          //  width: 60,
                        //    height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Loading...'),
                          )
                        ]),
                  );
                } else {
                  return Text("Error!");
                }
              },
            )
    ],)),

            Expanded(
              flex: 1,
              child:
              Obx(()=>
              (viewModel.admob_helper.issmall1BannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value )?
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
                  height: 0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.white,
                    child: Container(
                      color: Colors.grey,
                    ),
                  )
              )
              ),

            ),
          ],
        ));
  }
}
