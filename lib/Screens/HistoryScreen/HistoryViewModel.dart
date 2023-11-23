import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/DatabaseHandler.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/locationService.dart';


class HistoryViewModel extends GetxController {
  LocationService _service = LocationService();
  var users = <User>[].obs;
  Admob_Helper admob_helper = Admob_Helper();
  RxBool showProgressBar = true.obs;
//  AdsManager admob_helper = AdsManager();

  @override
  void onInit() {
    super.onInit();
    // Initialize the users list when the controller is created
    startTimer();
    fetchUsers();

    admob_helper.loadsmall1BannerAd();
  }

  Future<void> fetchUsers() async {
    users.value = await _service.getUsers();
    showProgressBar.value = false;
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 2), () {
      print("Show progress bar value"+showProgressBar.value.toString());
      showProgressBar.value = false;
      print("Show progress bar value12333"+showProgressBar.value.toString());
    });
  }
  Future<int> addUser(String SourceLocation, String DestinationLocation,double SourceLog, double SourceLath,double DestinationLog,double DestinationLath) async {
    int result = await _service.addUser(SourceLocation, DestinationLocation, SourceLog, SourceLath, DestinationLog, DestinationLath);
    if (result > 0) {
      // Reload the users list after adding a new user
      await fetchUsers();
    }
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await _service.updateUser(user);
    if (result > 0) {
      // Reload the users list after updating a user
      await fetchUsers();
    }
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result = await _service.deleteUser(id);
    print("result in userController is "+ result.toString());
    if (result > 0) {
      SnackBar mySnackBar = const SnackBar(
        content: Text('Item Deleted Successfully'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      );
      // Reload the users list after deleting a user
      await fetchUsers();
    }

    return result;
  }
  Future<int> deleteAllUser() async {
    int result = await _service.deleteAllUser();
    await fetchUsers();
    return result;
  }


  @override
  void onReady() {
   // admob_helper.adaptiveloadAd();
  //  admob_helper.loadInterstitalAd();
    super.onReady();
  }
}
