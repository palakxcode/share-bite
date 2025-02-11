import 'package:firstapp/constants/constants.dart';
import 'package:firstapp/services/location_service.dart';
import 'package:firstapp/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? _currentPosition;
  String? _errorMessage;
  GoogleMapController? _mapController;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _checkPermissionAndFetchLocation();
  }

  Future<void> _checkPermissionAndFetchLocation() async {
    try {
      await _locationService.checkAndRequestPermission();
      Position position = await _locationService.getCurrentLocation();
      setState(() {
        _currentPosition = position;
        _errorMessage = null;
      });
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      // buildSnackBar(error, _errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: _currentPosition == null
          ? _errorMessage == null
              ? const Center(child: BiteProgressIndicator())
              : Center(child: Text('$error: $_errorMessage'))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 14.0,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
