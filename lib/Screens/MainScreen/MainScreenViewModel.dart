
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreenViewModel extends GetxController {
  late PackageInfo packageInfo;
  Admob_Helper  admob_helper = Admob_Helper();

  @override
  Future<void> onInit() async {
    print('**** onInit *****');

    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');

    ///Load Ads Here
    admob_helper.loadInterstitalAd();
    //admob_helper.loadsmallBannerAd();

    super.onReady();
  }

  @override
  void onClose() {
    // admob_helper.nativeAdIsLoaded.value=false;
    // TODO: implement onClose
    super.onClose();
  }

  Future<bool> onWillPopfun(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Are you sure you want to exit?",
                style: TextStyle(color: Colors.black)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () => SystemNavigator.pop(),
                //Navigator.of(context).pop(true),
                child: Text("Yes",style: TextStyle(
                  color: Colors.white,
                ),),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No",style: TextStyle(
                    color: Colors.white,
                  ),)
              ),
            ],
          ),

    ) ?? false;
  }

  void openPlayStore() async {
    packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    if(Platform.isAndroid){
      Uri playStoreUrl = Uri.parse('https://play.google.com/store/apps/details?id='+packageName);
      if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    }
     if(Platform.isIOS){
      Uri playStoreUrl = Uri.parse('https://apps.apple.com/us/app/gps-navigation-map-direction/id1548093238');
      if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    }

  }
  Future<void> shareApp() async {
     String Link='';
    if(Platform.isAndroid) {
      packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;
       Link = 'https://play.google.com/store/apps/details?id='+packageName;
    }
    if(Platform.isIOS){
       Link='https://apps.apple.com/us/app/gps-navigation-map-direction/id1548093238';
      // final String appLink = 'https://play.google.com/store/apps/details?id='+packageName;
      //final String message = 'Check out my new app '+ioslink ;
    }
    final String message = 'Check out my new app '+Link ;

    // Share the app link and message using the share dialog
    //await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
    await FlutterShare.share(title: 'Share App', text: message);


    // Share the app link and message using the share dialog
    //await FlutterShare.share(title: 'Share App', text: message, linkUrl: appLink);
   // await FlutterShare.share(title: 'Share App', text: message);
  }
  Future<bool> showExitPopup(context) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Custom Dialog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('This is a custom AlertDialog with a white background.'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }













}