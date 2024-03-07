import 'package:permission_handler/permission_handler.dart';

class LocationPermissionUsecase {
  Future<void> call() async {
    try {
      final isEnabled = await Permission.location.isGranted;

      if (!isEnabled) {
        final checkPermission = await Permission.location.request();
        if (checkPermission.isDenied) {
          throw PermissionDenied();
        } else if (checkPermission.isPermanentlyDenied) {
          throw PermissionPermanentlyDenied();
        }
      }
    } catch (e) {
      print("Exception: $e");
      throw e;
    }
  }
}

class PermissionDenied {
  final String? message;
  PermissionDenied({this.message});
}

class PermissionPermanentlyDenied {
  final String? message;
  PermissionPermanentlyDenied({this.message});
}
