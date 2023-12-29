// // ignore_for_file: use_build_context_synchronously

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeolocatorUtil {
  Future<Position> checkLocationServices() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
   
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else
      _obtainLocation();
    return await Geolocator.getCurrentPosition();
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
