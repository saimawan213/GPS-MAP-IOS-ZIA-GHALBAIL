import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/HistoryView.dart';
import 'package:mapsandnavigationflutter/Screens/MainScreen/MainScreenViewModel.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final viewModel = Get.find<MainScreenViewModel>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      viewModel.admob_helper.mainisBannerLoaded.value = false;
    });
  }

  @override
  void dispose() {
    viewModel.admob_helper.mainjadaptiveloadAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
