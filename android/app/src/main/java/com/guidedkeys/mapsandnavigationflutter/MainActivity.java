package com.guidedkeys.mapsnavigation;

import io.flutter.embedding.android.FlutterActivity;

import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognitionListener;
import android.speech.RecognizerIntent;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.jar.JarException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;


public class MainActivity extends FlutterActivity {
  //  private static final String CHANNEL = "com.guidedkeys.mapsandnavigationflutter/speechToText";
   // MethodChannel.Result methodResult;

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        // TODO: Register the ListTileNativeAdFactory

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "smallListTile",
                new NativeAdFactorySmall(getContext()));
      /*  GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileMedium",
                new NativeAdFactoryMedium(getContext()));
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileMedium2",
                new NativeAdFactoryMedium2(getContext()));*/

        // TODO: Platform Channel
     /*   new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getTextFromSpeech")) {
                                String languageISO = call.argument("languageISO");
                                SpeechToText(result, languageISO);
                            } else {
                                System.out.println("My Function Not Implemented In Java");
                                result.notImplemented();
                            }
                        }
                );*/
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium2");
    }


   /* public void SpeechToText(MethodChannel.Result result, String languageISO) {
        this.methodResult = result;
        Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.EXTRA_LANGUAGE_MODEL);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, languageISO);
        intent.putExtra(RecognizerIntent.EXTRA_PROMPT, "Say something...");
        startActivityForResult(intent, 1001);
    }*/

    //    @Override
//    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
//        super.onActivityResult(requestCode, resultCode, data);
//        if (requestCode == 1001) {
//            try {
//            if (resultCode == RESULT_OK && data != null) {
//
//                    final ArrayList<String> result = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
//                    String mSentence = result.get(0);
//                    Map<String, Object> response = new HashMap<>();
//                    response.put("Success", true);
//                    response.put("Result", mSentence);
//                    methodResult.success(response);
//
//            } else {
//                handleException(null); // Pass null to indicate no specific exception
//            }
//        }
//            catch (Exception e) {
//                handleException(e);
//            }
//        }
//    }
   /* @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1001) {
            try {
                if (resultCode == RESULT_OK && data != null) {
                    final ArrayList<String> result = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);
                    String mSentence = result.get(0);
                    Map<String, Object> response = new HashMap<>();
                    response.put("Success", true);
                    response.put("Result", mSentence);
                    methodResult.success(response);
                } else {
                    handleException(new Exception("Speech recognition failed."));
                }
            } catch (Exception e) {
                handleException(e);
            } finally {
                // Ensure that methodResult.success is called only once
                methodResult = null;
            }
        }
    }*/


    /*private void handleException(Exception e) {
        Map<String, Object> response = new HashMap<>();
        response.put("Success", false);
        if (e != null) {
            // You can optionally log the exception or extract more information here
            // For example: Log.e("YourTag", "Exception in onActivityResult", e);
            response.put("ErrorMessage", e.getMessage());
            response.put("This IS JAVA ERROR ---------- -- - - - -  - -", e.getMessage());
        }

        methodResult.success(response);
    }*/

}


