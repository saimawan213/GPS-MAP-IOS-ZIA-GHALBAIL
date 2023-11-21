



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';

class MainScreenViewModel extends GetxController {

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
    admob_helper.loadsmallBannerAd();

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