import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper_Impl.dart';
import 'package:mapsandnavigationflutter/Screens/Constents/Constent.dart';

class WorldClockViewModel extends GetxController {
  List<String> stringList = [];
  RxMap data = {}.obs;
  RxBool checknet = true.obs;
  RxString Sunrise = ''.obs;
  RxString Sunset = ''.obs;
  RxString windSpeed = ''.obs;
  RxString pressure = ''.obs;
  RxString humidity = ''.obs;
  RxString clouds = ''.obs;

  Admob_Helper admob_helper = Admob_Helper();

  @override
  Future<void> onInit() async {
    print('**** onInit *****');
    setupWorldTime();
    // FlutterNativeSplash.remove();
    super.onInit();
  }

  @override
  void onReady() {
    print('**** onReady *****');

    ///Load Ads Here

    admob_helper.adaptiveloadAd();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    admob_helper.isBannerLoaded.value = false;
    admob_helper.anchoredAdaptiveAd = null;
  }

  void setData(weatherData) {
    int sunrise = (weatherData['sys']['sunrise']) * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(sunrise);
    String sunriseformattedTime = DateFormat('hh:mm:ss a').format(dateTime);
    Sunrise.value = sunriseformattedTime;
    int sunset = (weatherData['sys']['sunset']) * 1000;
    DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(sunset);
    String sunsetformattedTime = DateFormat('hh:mm:ss a').format(dateTime1);
    Sunset.value = sunsetformattedTime;
    print("weatherdata123:" + weatherData.toString());
    print("weatherdata:" + weatherData['main']['temp'].round().toString());
    print("Wind speed:" + weatherData['wind']['speed'].toString());
    windSpeed.value = weatherData['wind']['speed'].toString();
    print("Humidity:" + weatherData['main']['humidity'].toString());
    humidity.value = weatherData['main']['humidity'].toString();
    print("Sun rise:" + sunriseformattedTime);
    print("Sun set:" + sunsetformattedTime);
    print("Pressure:" + weatherData['main']['pressure'].toString());
    pressure.value = weatherData['main']['pressure'].toString();
    print("clouds:" + weatherData['clouds']['all'].toString());
    clouds.value = weatherData['clouds']['all'].toString();
  }

  void resetData() {
    Sunrise.value = 'N/A';
    Sunset.value = 'N/A';
    windSpeed.value = 'N/A';
    humidity.value = 'N/A';
    pressure.value = 'N/A';
    clouds.value = 'N/A';
  }

  Future setupWorldTime() async {
    if (await Constent.checkIntenetConnection()) {
      // final prefs = await SharedPreferences.getInstance();
      Constent instance = Constent(flag: 'germany.png', location: '', url: '');
      await instance.getTimebyip();
      await instance.getWeather();

      //final location = prefs.getString('location') ?? instance.location;
      //  final url = prefs.getString('url') ?? instance.url;

      /*  stringList.add(instance.location);
      stringList.add(instance.flag!);
      stringList.add(instance.time!);
      stringList.add(instance.isDaytime!.toString());
stringList.add(instance.url!);*/

      data["location"] = instance.location;
      print("qq new 111223:" + data["location"]);
      data["flag"] = instance.flag;
      data["time"] = instance.time;
      data["isDaytime"] = instance.isDaytime;
      data["url"] = instance.url;
      data["weatherData"] = instance.weatherData;
      setData(data['weatherData']);

      /*  Constent.location1 = instance.location;
      Constent.flag1 = instance.flag!;
      Constent.time1 = instance.time!;
      Constent.isDaytime1 = instance.isDaytime!;
      Constent.url1 = instance.url!;
      Constent.weatherData1 = instance.weatherData;*/
      /*Navigator.pushReplacementNamed(arguments: {
        "location": instance.location,
        "flag": instance.flag,
        "time": instance.time,
        "isDaytime": instance.isDaytime,
        "url": instance.url,
        "weatherData": instance.weatherData
      });*/
      checknet.value = true;
      //Navigator.pushNamed(context, '/home');
      // we push this route on top of the loading route, but we dont want to keep the loading routes underneath so :
      /*   Navigator.pushReplacementNamed(context, '/home', arguments: {
        "location": instance.location,
        "flag": instance.flag,
        "time": instance.time,
        "isDaytime": instance.isDaytime,
        "url": instance.url,
        "weatherData": instance.weatherData
      });*/
    } else {
      checknet.value = false;
      /* Constent.showNoConnectionDialog(context).then((data) async {
        await setupWorldTime();
      });*/
    }
  }

/*Future<bool> onWillPopfun(BuildContext context) async {
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
              onPressed: () =>  Navigator.of(context).pop(false),
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
}*/
  void showDialog(
      {required BuildContext context,
      required AlertDialog Function(BuildContext context) builder}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog Title'),
          content: Text('This is a simple dialog box.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
