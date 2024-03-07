import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GeneralDataProtectionRegulationHelper {
  final GetStorage storage = GetStorage(); // Create an instance of get_storage

  Future<FormError?> requestConsentInfoUpdate() async {
    final completer = Completer<FormError?>();
    final params = ConsentRequestParameters(
      consentDebugSettings: ConsentDebugSettings(
        debugGeography: DebugGeography.debugGeographyEea,
        testIdentifiers: [
          "EA45BD96A6C174F630C8F49C1774855A",
          "BE03A9039FACD6F7068C726C43BF26E0"
        ],
      ),
    );

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      successListener,
      (error) => error,
    );
    return completer.future;
  }

  Future<void> successListener() async {
    final isAvailable =
        await ConsentInformation.instance.isConsentFormAvailable();
    if (await ConsentInformation.instance.isConsentFormAvailable()) {
      await _loadConsentForm();
    } else {}
  }

  Future<void> _loadConsentForm() async {
    ConsentForm.loadConsentForm((consentForm) async {
      final status = await ConsentInformation.instance.getConsentStatus();
      if (status == ConsentStatus.required) {
        consentForm.show((formError) {
          _loadConsentForm();
        });
      }
    }, (formError) {});
  }
}
