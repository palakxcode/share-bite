import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<void> checkAndRequestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool opened = await Geolocator.openLocationSettings();
      if (!opened) {
        throw Exception(
            'Could not open location settings. Please enable location services manually.');
      }
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception(
            'Location permissions are denied. Please grant permissions in your device settings.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are denied. Please grant permissions in your device settings.');
    }
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );
  }

  Future<String> getAddressFromLatLng(
      Position position, BuildContext context) async {
    try {
      List<geocoding.Placemark> places =
          await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      geocoding.Placemark place = places.first;
      return '${place.street}, ${place.locality}, ${place.country}';
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
      return 'Error fetching address';
    }
  }
}
