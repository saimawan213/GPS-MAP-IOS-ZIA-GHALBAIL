import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper_Impl.dart';
import 'package:url_launcher/url_launcher.dart';

class NearByLocationViewModel extends GetxController {
  TextEditingController editingController = TextEditingController();
  RxList<String> duplicateItems = <String>[].obs;
  RxList<String> items = <String>[].obs;
  Admob_Helper admob_helper = Admob_Helper();

  @override
  Future<void> onInit() async {
    print('**** onInit *****');

    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    print('**** onReady *****');

    ///Load Ads Here
    admob_helper.adaptiveloadAd();
    final String jsonString =
        await rootBundle.loadString('assets/categories.json');
    final data = jsonDecode(jsonString);
    print(data['pois']);
    List<dynamic> list = data['pois'];
    for (var i = 0; i < list.length; i++) {
      // TO DO
      items.add(list[i]);
      duplicateItems.add(list[i]);
      print("data 123:" + list[i]);

      //   var currentElement = li[i];
    }
    /* String googleUrl='https://www.google.com/maps/search/?api=1&query=School';
                            if (await canLaunch(googleUrl)) {
                              await launch(googleUrl);
                            } else {
                              throw 'Could not open the map.';
                            }*/

    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    admob_helper.isBannerLoaded.value = false;
    admob_helper.anchoredAdaptiveAd = null;
  }

  void filterSearchResults(String query) {
    items.clear();
    items.addAll(duplicateItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList()); /*duplicateItems
          .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();*/
    print("value of items${items.length}");
    //speech.cancel();
    //  speech.stop();
  }

  Future<void> callgooglemap(String index) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=' + index;
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl, forceWebView: false, forceSafariVC: false);
//    await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
