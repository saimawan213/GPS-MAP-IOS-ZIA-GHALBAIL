import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionPopup extends StatelessWidget {
  const LocationPermissionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Location Permission Required'),
      content: Text('This app requires access to your location to get current'
          ' address.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            Navigator.of(context).pop();
          },
          child: Text('Open App Settings'),
        ),
      ],
    );
  }
}
