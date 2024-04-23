import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/InAppPurchase/InAppPurchaseViewModel.dart';

class inAppPurchase extends StatelessWidget {
  InAppPurchaseViewModel viewModel = Get.put(InAppPurchaseViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Add your back button onPressed logic here
            Navigator.pop(context);
            // Get.to(() => ExitScreen_View());
          },
        ),
        title: const Text("In App Purchase",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  /* child: Lottie.asset(
                  'assets/lottie/adspurchase.json',
                  height: 50.0,
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),*/
                  /* margin: EdgeInsets.all(10),
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Click on Price Button to Remove all Ads From the App",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.buyLifeTimeSubscription();
                        // Add your action here
                      },
                      child: Text(viewModel.price),
                      style: TextButton.styleFrom(
                        primary: Colors.white, // Text and icon color
                        backgroundColor: Colors.blue, // Button background color
                      ),),
                  ],
                ),*/
                  /*TextButton(
                  style: TextButton.styleFrom(
                    // backgroundColor: Colors.green[800],
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    viewModel.buyLifeTimeSubscription();
                    // getPurchaseHistory();
                    //  return;




                    }, child: Text(viewModel.price),

                    //   getPurchaseHistory();

                 // child: Text(productDetails.price),
                ),*/
                  ),
            ),
            /*  Expanded(
                flex: 1,
                child:
                Container(
                )
            ),*/
            Expanded(
              flex: 1,
              child: Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Click on Price Button to Remove all Ads From the App",
                          style: TextStyle(color: Colors.blue)),
                    ),
                    TextButton(
                      onPressed: () {
                        viewModel.buyLifeTimeSubscription(context);
                        // Add your action here
                      },
                      child: Text(viewModel.lifeTimePrice.value),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white, // Text and icon color
                        backgroundColor: Colors.blue, // Button background color
                      ),
                    ),
                  ],
                ),
                /*TextButton(
                  style: TextButton.styleFrom(
                    // backgroundColor: Colors.green[800],
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    viewModel.buyLifeTimeSubscription();
                    // getPurchaseHistory();
                    //  return;




                    }, child: Text(viewModel.price),

                    //   getPurchaseHistory();

                 // child: Text(productDetails.price),
                ),*/
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}
