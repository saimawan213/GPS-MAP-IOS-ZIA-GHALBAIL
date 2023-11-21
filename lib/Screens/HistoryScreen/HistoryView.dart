import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Colors.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';
import 'package:mapsandnavigationflutter/Screens/HistoryScreen/HistoryViewModel.dart';
import 'package:mapsandnavigationflutter/Screens/NavigationScreen/NavigationScreenView.dart';
import 'package:shimmer/shimmer.dart';



/*
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return UserListWidget();
  }
}
*/

class HistoryView extends StatelessWidget {
  HistoryViewModel  viewModel = Get.put(HistoryViewModel());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor:AppColor.primaryColor,
        title: Text(
          " History",
          style: TextStyle(
            color: Colors.white,
            // letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          /* IconButton(
      icon: Image.asset('assets/images/noads.png',height: 30,color: Colors.white,),

        onPressed: () {
          Get.to(() => MyInApp());
          // Handle your icon tap here
        },*/

          IconButton(
            icon: Icon(Icons.delete_forever),
            color: Colors.white,

            onPressed: () {
              viewModel.deleteAllUser();

              // Handle your icon tap here
            },



          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
/*Expanded(
              flex: 1,
             // child: appBar(),
            ),*/

            Expanded(
              flex: 10,
              child:Obx(()=> viewModel.showProgressBar.value
                  ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor), // Set color here
                ),
              ): Obx(() =>(viewModel.users.isEmpty) ? Lottie.asset(
                'assets/nodatafound.json',
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,
              ):
                  SingleChildScrollView(
                child: Column(
                  children:

                  List.generate(viewModel.users.length, (index) {
                    var user = viewModel.users[index];
                    // Replace this with your actual item widget
                    return Container(
                      margin: EdgeInsets.only(left: 30.0,right: 30.0,top:15.0,bottom: 15.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.primaryColor,  // You can set the border color here.
                          width: 2.0,          // You can set the border width here.
                        ),
                        color: Colors.white, // Set the background color of the container
                        borderRadius: BorderRadius.circular(16.0), // Set the corner radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey, // Set the shadow color
                            offset: Offset(0, 2), // Set the shadow offset
                            blurRadius: 4.0, // Set the blur radius
                            spreadRadius: 0, // Set the spread radius
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
/*ReadMoreText(
                            textAlign: TextAlign.start,
                            user.id.toString(),
                            trimLines: 1,
                            preDataText: "",
                            preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                            style: TextStyle(color: Colors.black),
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            //trimCollapsedText: '...Show detail',
                            //trimExpandedText: ' show less',
                          ),*/

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                               margin: EdgeInsets.only(top:6.0,left: 16.0,right: 16.0),
                                child: const Text(

                                  textAlign: TextAlign.start,
                                 "Source:",
                                  // trimLines: 1,
                                  //   preDataText: "",
                                  //   preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  // colorClickableText: Colors.pink,
                                  //  trimMode: TrimMode.Line,
                                  //trimCollapsedText: '...Show detail',
                                  //trimExpandedText: ' show less',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 40.0),
                                child: Text(

                                  textAlign: TextAlign.start,
                                  user.SourceLocation ?? "",
                                 // trimLines: 1,
                         //   preDataText: "",
                         //   preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                  style: TextStyle(color: Colors.black,),
                                 // colorClickableText: Colors.pink,
                                //  trimMode: TrimMode.Line,
                                  //trimCollapsedText: '...Show detail',
                                  //trimExpandedText: ' show less',
                                ),
                              ),
                            ],
                          ),
    /*  Text(
                            textAlign: TextAlign.start,
                            user.distinationText ?? "",
                          //  trimLines: 1,
                          //  preDataText: "",
                           // preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                            style: TextStyle(color: Colors.black),
                         //   colorClickableText: Colors.pink,
                         //   trimMode: TrimMode.Line,
                            //trimCollapsedText: '...Show detail',
                            //trimExpandedText: ' show less',
                          ),*/


                          SizedBox(height: 5.0,),
                          Divider(
                            color: AppColor.primaryColor,
                          ),
                          SizedBox(height: 5.0,),

                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top:6.0,left: 16.0,right: 16.0),
                                child: const Text(

                                  textAlign: TextAlign.start,
                                  "Destination:",
                                  // trimLines: 1,
                                  //   preDataText: "",
                                  //   preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  // colorClickableText: Colors.pink,
                                  //  trimMode: TrimMode.Line,
                                  //trimCollapsedText: '...Show detail',
                                  //trimExpandedText: ' show less',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 40.0),
                                child: Text(
                                  textAlign: TextAlign.start, user.DestinationLocation ?? "",
                                //  trimLines: 1,
                                 // preDataText: "",
                                 // preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                                  style: TextStyle(color: Colors.black),
                                 // colorClickableText: Colors.pink,
                                //  trimMode: TrimMode.Line,
                                  //trimCollapsedText: '...Show detail',
                                  //trimExpandedText: ' show less',
                                ),
                              ),
                            ],
                          ),
/* Text(
                            textAlign: TextAlign.start,
                            user.translatedText ?? "",
                           // trimLines: 1,
                         //   preDataText: "",
                          //  preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                            style: TextStyle(color: Colors.black),
                          //  colorClickableText: Colors.pink,
                          //  trimMode: TrimMode.Line,
                            //trimCollapsedText: '...Show detail',
                            //trimExpandedText: ' show less',
                          ),*/

                          SizedBox(height: 12.0,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                 Get.to(() => NavigationScreenView(),
                                    arguments: {"source": user.SourceLocation,"destination": user.DestinationLocation,"Sourcelath":user.SourceLath,"Sourcelog":user.SourceLog,"destinationlath":user.DestinationLath,"destinationlog":user.DestinationLog});
                                 // userController.admob_helper.showInterstitialAd();
                                  //Get.toNamed(RoutesName.textView);
                                 // Get.toNamed(RoutesName.textView, arguments: {'view': "pdf", 'text': user.distinationText, 'translatedTextAlready': user.translatedText});
                                },
                                child:

                                Container(
                                  width: 50.0, // Adjust the width as needed
                                  height: 50.0, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor, // Background color for the circular icon
                                  ),
                                  alignment: Alignment.center,

                                  child:const Icon(Icons.navigation, color: Colors.white,),


                                  /*Image(
                                    width: 30,
                                    height: 30,
                                    color: Colors.white,
                                    Icon(Icons.camera_alt), // Replace with the correct asset path
                                  ),*/ /*Container(
          width: 40.0, // Adjust the width as needed
          height: 40.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/"+todo!+".png")
            ),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
          ),
        ),*/
                                ),
                                /*Container(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                  decoration: BoxDecoration(

                                    color: Colors.blue,
                                  ),
                                  child: Text(
                                    'Map View',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),*/
                              ),
                              SizedBox(width: 6,),
                              SizedBox(width: 6,),
                              InkWell(
                                onTap: (){
                                //  userController.admob_helper.showInterstitialAd();
                                  print("User Id for delete is "+user.id.toString());
                                  viewModel.deleteUser(user.id!);
                                  //Get.toNamed(RoutesName.textView);
                                  //Get.toNamed(RoutesName.textView, arguments: {'view': "camera", 'text': user.distinationText});
                                },
                                child:Container(
                                  width: 50.0, // Adjust the width as needed
                                  height: 50.0, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primaryColor, // Background color for the circular icon
                                  ),
                                  alignment: Alignment.center,
                                  child:const Icon(Icons.delete, color: Colors.white,),


                                  /*Image(
                                    width: 30,
                                    height: 30,
                                    color: Colors.white,
                                    Icon(Icons.camera_alt), // Replace with the correct asset path
                                  ),*/ /*Container(
          width: 40.0, // Adjust the width as needed
          height: 40.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/"+todo!+".png")
            ),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
          ),
        ),*/
                                ),

                                /*Container(
                                  padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                                  decoration: BoxDecoration(

                                    color:Colors.blue,
                                  ),
                                  child: Text(
                                    'Delete Item',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),*/
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),

                        ],
                      ),
                    );
                  }),
                ),
              )),
            )),
            Expanded(
              flex: 1,
              child:
              Obx(()=>
              (viewModel.admob_helper.issmall1BannerLoaded.value && !Constent.isOpenAppAdShowing.value && !Constent.isInterstialAdShowing.value && !viewModel.users.isEmpty)?
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
                  :(viewModel.users.isEmpty)?SizedBox():SizedBox(
                  width:double.infinity,
                  height: 30,
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
/*Expanded(
              flex: 1,
              child: showBannerAd(),
            ),*/

            //const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

/*
  Widget appBar() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),    // No radius at the top-left corner
            topRight: Radius.circular(0.0),   // No radius at the top-right corner
            bottomLeft: Radius.circular(20.0), // Radius at the bottom-left corner
            bottomRight: Radius.circular(20.0),// Radius at the bottom-right corner
          ),
        ),
        height: AppBar().preferredSize.height+22,
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(onPressed: (){},
                icon: Icon(Icons.arrow_back, color: Colors.white),),
Padding(
                padding:  EdgeInsets.only(top: 8, left: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Text(
                  'Translation History',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ]));
  }
*/


/*Widget showBannerAd(){
    return Obx(
          ()=>
      homeScreenController.admob_helper.isBannerLoaded.value && !Constants.isOpenAppAdShowing.value
          ?
      Container(
        color: AppColor.adsBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 2,bottom: 2),
          child: Container(
            alignment: Alignment.center,
            width: homeScreenController.admob_helper.anchoredAdaptiveAd?.size.width.toDouble(),
            height: homeScreenController.admob_helper.anchoredAdaptiveAd?.size.height.toDouble(),
            child: AdWidget(ad: homeScreenController.admob_helper.anchoredAdaptiveAd!),
          ),
        ),
      )
          :
      SizedBox(),
    );
  }*/

}
