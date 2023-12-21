// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeolocatorUtil {
  static Future<void> checkLocationServices(BuildContext context) async {
    bool locationServicesEnabled = await Geolocator.isLocationServiceEnabled();

    if (!locationServicesEnabled) {
      // Location services are not enabled
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Enable Location Services"),
            content: const Text("Please enable location services to proceed."),
            actions: [
              TextButton(
                onPressed: () async {
                  Geolocator.openLocationSettings();

                  bool updatedLocationServicesEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (updatedLocationServicesEnabled) {
                    Navigator.pop(context);
                    _obtainLocation();
                  }
                },
                child: const Text("Open Settings"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle the case where the user chooses not to enable location services
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );
    } else {
      _obtainLocation();
    }
  }

  static Future<void> _obtainLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final longitude = position.longitude;
    final latitude = position.latitude;
    final pref = await SharedPreferences.getInstance();
    await pref.setDouble('longitude', longitude);
    await pref.setDouble('latitude', latitude);
  }
}
