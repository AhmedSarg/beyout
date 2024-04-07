import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapScreenShare extends StatefulWidget {
  const GoogleMapScreenShare({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreenShare> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreenShare> {
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  LatLng? initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content: Text('Please enable location services to use this feature.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (permission == LocationPermission.deniedForever) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Location Permission Denied'),
            content: Text('Location permission is permanently denied. Please go to app settings to enable it.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Geolocator.openAppSettings();
                },
                child: Text('App Settings'),
              ),
            ],
          ),
        );
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          initialCameraPosition = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  Future<String> _getNearestCity(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        String cityName = placemarks.first.locality ?? 'Unknown';
        return cityName;
      }
    } catch (e) {
      print('_________________________________________');
      print('Error getting city name: $e');
    }
    return 'Unknown';
  }

  void _onMapTap(LatLng tappedPoint) async {
    String cityName = await _getNearestCity(tappedPoint);
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: cityName,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          if (initialCameraPosition != null)
            GoogleMap(
              compassEnabled: true,
              fortyFiveDegreeImageryEnabled: true,
              buildingsEnabled: true,
              scrollGesturesEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              mapType: MapType.normal,
              onTap: _onMapTap,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: initialCameraPosition!,
                zoom: 14.0,
              ),
            ),
        ],
      ),
    );
  }
}