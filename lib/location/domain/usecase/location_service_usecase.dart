import 'package:permission_handler/permission_handler.dart';

class LocationServicePermissionUsecase {
  Future<void> call() async {
    final serviceStatus = await Permission.location.serviceStatus;
    if (serviceStatus.isDisabled) {
      throw LocationServiceDisabledException();
    }
  }
}

class LocationServiceDisabledException {
  final String? message;
  LocationServiceDisabledException({this.message});
}
