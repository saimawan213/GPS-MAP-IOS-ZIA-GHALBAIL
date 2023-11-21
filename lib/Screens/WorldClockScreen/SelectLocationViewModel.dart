import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';

class SelectLocationViewModel extends GetxController {
  TextEditingController editingController = TextEditingController();
  var future;
  Admob_Helper admob_helper = Admob_Helper();
  RxString searchString = "".obs;
  RxBool pcodeshowProgressBar = true.obs;
  @override
  Future<void> onInit() async {
    print('**** onInit *****');
    future = Constent.getCountriesList();
    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  void onReady() {
    admob_helper.loadsmall1BannerAd();
  //  future = Get.arguments['countrylist'];
  //  items=Get.arguments['countrylist'];
    //duplicateItems=Get.arguments['countrylist'];
    print("dataa is:"+future.toString());
    print('**** onReady *****');
    ///Load Ads Here

    super.onReady();
  }
  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();
  }
  void startTimer() {
    Future.delayed(Duration(seconds: 2), () {
      print("Show progress bar value"+pcodeshowProgressBar.value.toString());
      pcodeshowProgressBar.value = false;
      print("Show progress bar value12333"+pcodeshowProgressBar.value.toString());
    });
  }
/*
  void filterSearchResults(String query) {

    // ptts11.value=true;


    items.clear();
    items.addAll(duplicateItems
        .where((item) => item.url!.toLowerCase().contains(query.toLowerCase()))
        .toList()); */
/*duplicateItems
          .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();*//*

    print("value of items${items.length}");
    //speech.cancel();
    //  speech.stop();
  }
*/


}
