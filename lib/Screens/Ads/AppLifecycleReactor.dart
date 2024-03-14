import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mapsandnavigationflutter/Screens/Ads/Admob_Helper_Impl.dart';

class AppLifecycleReactor {
  final Admob_Helper appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    print('New AppState state: $appState');
    // if(AppConst.adspurchase) {
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
    if (appState == AppState.background) {
      appOpenAdManager.showAdIfAvailable();
    }
    // }
  }
}
