import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'permission.service.dart';

class CurrentLocation {
  final double longitude;
  final double latitude;
  final Placemark address;
  final String googleUrl;
  const CurrentLocation(
      {required this.latitude,
      required this.longitude,
      required this.address,
      required this.googleUrl});
}

class LocationService {
  static Future<CurrentLocation?> getCurrentLocation(
      BuildContext context) async {
    if (!(await PermissionService.getLocationPermission())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not able to proceed. Please provide location access'),
        ),
      );
      return null;
    }

    if (!(await Geolocator.isLocationServiceEnabled())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not able to proceed. Please open location service'),
        ),
      );
      return null;
    }

    final Position position = await Geolocator.getCurrentPosition();
    print('Current Position -> $position');
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print('Current Address -> ${placemarks[0]}');
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    print('Google Url of Current Location -> $googleUrl');
    return CurrentLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: placemarks[0],
        googleUrl: googleUrl);
  }
}
