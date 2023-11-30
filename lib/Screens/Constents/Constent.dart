import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class Constent {
  static double Splashcurrentlath=0.0;
  static double Splashcurrentlog=0.0;
  static String splashcurrentAddress = '';
  static late Position splashcurrentPosition;
  String location; //location name for the UI
  String? time; // the time in that location
  String? flag; // URL to an asset flag icon
  String? url; //location url for API endpoint
  bool? isDaytime;
  static RxBool isOpenAppAdShowing = false.obs;
  static RxBool isInterstialAdShowing = false.obs;

  static bool isAlternativeInterstitial = true;
  static bool appopencheck=true;
  static RxBool purchaseads=false.obs;
  static bool adspurchase=false;
 /* static  String location1 = '';
  static  String flag1 = '';
  static  String time1 = '';
  static  bool isDaytime1=false;
  static  String url1 = '';
  static  var weatherData1 = '';*/
  static const _endPoint = "http://worldtimeapi.org/api/timezone";
  static const _endPoint1 = "http://worldtimeapi.org/api/ip";
  static const _weatherAPI = "https://api.openweathermap.org/data/2.5/weather";
  var weatherData;

  // Constructor
  Constent({required this.location, this.flag, this.url});

  Future<void> getTime() async {
    // Future is like promise in JS, void means that i will return void but only when the function is fully complete
    try {
      var url_path = Uri.parse('$_endPoint/$url');
      Response response = await get(url_path);
      Map data = jsonDecode(response.body);
      DateTime now = DateTime.parse(data["datetime"]);
      int offset = int.parse(data["utc_offset"].substring(1, 3));
      String operator = data["utc_offset"].substring(0, 1);
      if (operator == "+") {
        now = now.add(new Duration(hours: offset));
      } else if (operator == "-") {
        now = now.subtract(new Duration(hours: offset));
      }
      //Set time property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print(e);
      time = "could not get time data";
    }
  }

  static Future<List<Constent>> getCountriesList() async {
    var url_path = Uri.parse(_endPoint);
    Response response = await get(url_path);
    List data = jsonDecode(response.body);
    List<Constent> countryList = data.map((e) {
      String cityName = e.substring(e.lastIndexOf('/') + 1);
      cityName = cityName.replaceAll('_', ' ');
      return Constent(url: e, location: cityName);
    }).toList();
    print("ia amm heeee:"+countryList.length.toString());
    return countryList;
  }
  Future<void> getTimebyip() async {
    // Future is like promise in JS, void means that i will return void but only when the function is fully complete
    try {
      var url_path = Uri.parse('$_endPoint1');
      Response response = await get(url_path);
      Map data = jsonDecode(response.body);
      DateTime now = DateTime.parse(data["datetime"]);
      int offset = int.parse(data["utc_offset"].substring(1, 3));
      String operator = data["utc_offset"].substring(0, 1);
      url = data["timezone"];
      String name1=data["timezone"];
      location = name1.substring(name1.lastIndexOf('/') + 1);
      print("locationb iaasas:"+location);
      // getWeather1(cityName1);
      if (operator == "+") {
        now = now.add(new Duration(hours: offset));
      } else if (operator == "-") {
        now = now.subtract(new Duration(hours: offset));
      }
      //Set time property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print(e);
      time = "could not get time data";
    }
  }
/*  Future<void> getWeather1() async {
    try {
      var url_path = Uri.parse(
          '$_weatherAPI?q=${cityName1}&appid=8eac49d2c3bca1c82c9bc8271ed19b83&lang=de&units=metric');
      Response response = await get(url_path);
      Map data = jsonDecode(response.body);
      weatherData = data;
    } catch (e) {
      print(e);
    }
  }*/
  Future<void> getWeather() async {
    try {
      var url_path = Uri.parse(
          '$_weatherAPI?q=${location}&appid=8eac49d2c3bca1c82c9bc8271ed19b83&lang=de&units=metric');
      Response response = await get(url_path);
      Map data = jsonDecode(response.body);
      weatherData = data;
    } catch (e) {
      print(e);
    }
  }
  static Future checkIntenetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');

      return false;
    }
  }
  static showNoConnectionDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.white,
            title: Text('No internet connection',
              style: TextStyle(color: Colors.black)),
              content: const Text('Please check your internet connection!'),
            actions: [

              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Close",style: TextStyle(
                    color: Colors.white,
                  ),)
              ),
            ],
          ),

    );
  }
/*  static showNoConnectionDialog(BuildContext context)  {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('No internet connection'),
        content: const Text('Please check your internet connection!'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(false);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }*/


// static RxBool pcodeshowProgressBar = true.obs;
  //static bool testAd = false;



  static String get bannerAdID{

    if(Platform.isAndroid){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/6300978111';
      }
      else{
        return 'ca-app-pub-8011932915847069/1156033646';
      }

    }else if(Platform.isIOS){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/2934735716';
      }
      else{
        return 'ca-app-pub-6941637095433882/5799117821';
      }

    }else{
      throw UnsupportedError("Un supported");
    }

  }

  static String get interstialAdID{
    if(Platform.isAndroid){
      print("call interstialad");
      if(kDebugMode){
        print("call11 interstialad");
        return 'ca-app-pub-3940256099942544/1033173712';
      }
      else{
        print("call11565 interstialad");
        return 'ca-app-pub-8011932915847069/9295405784';
      }

    }else if(Platform.isIOS){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/4411468910';
      }
      else{
        return 'ca-app-pub-6941637095433882/6431147997';
      }

    }else{
      throw UnsupportedError("Un supported");
    }

  }
  static String get openupAdID{

    if(Platform.isAndroid){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/3419835294';
      }
      else{
        return 'ca-app-pub-8011932915847069/3496452020';
      }

    }else if(Platform.isIOS){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/5662855259';
      }
      else{
        return 'ca-app-pub-6941637095433882/7998618403';
      }

    }else{
      throw UnsupportedError("Un supported");
    }

  }

  static String get nativeAdID{
    if(Platform.isAndroid){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/2247696110';
      }
      else{
        return 'ca-app-pub-8011932915847069/3590625295';
      }

    }else if(Platform.isIOS){
      if(kDebugMode){
        return 'ca-app-pub-3940256099942544/3986624511';
      }
      else{
        return 'ca-app-pub-6941637095433882/2954476333';
      }

    }else{
      throw UnsupportedError("Un supported");
    }

  }

}
