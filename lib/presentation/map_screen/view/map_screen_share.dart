import 'dart:typed_data';
import 'dart:ui' as ui; // Add this import statement

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../../share_post_screen/viewmodel/share_view_model.dart';

class GoogleMapScreenShare extends StatefulWidget {
  final ShareViewModel? viewModel;

  const GoogleMapScreenShare({Key? key, this.viewModel}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreenShare> {
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  LatLng? selectedLocation;

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
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error getting user location: $e');
    }
  }

  Future<String> _getNearestCity(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        String cityName = placemarks.first.locality ?? 'Unknown';
        return cityName;
      }
    } catch (e) {
      print('Error getting city name: $e');
    }
    return 'Unknown';
  }

  Future<Map<String, Object>> _onMapTap(LatLng tappedPoint) async {
    LatLng coordinates = tappedPoint;

    print(
        'Latitude: ${coordinates.latitude}, Longitude: ${coordinates.longitude}');

    String cityName = await _getNearestCity(coordinates);

    widget.viewModel?.getLocationController.text = cityName;

    Uint8List markerIconBytes = await getBytesFromAsset(ImageAssets.pin, 100);
    BitmapDescriptor icon = BitmapDescriptor.fromBytes(markerIconBytes);

    setState(() {
      selectedLocation = coordinates;
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(coordinates.toString()),
          position: coordinates,
          icon: icon,
          infoWindow: InfoWindow(
            snippet: cityName,
          ),
        ),
      );
    });

    return {'city': cityName, 'coordinates': coordinates};
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: AppSize.s80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: AppSize.s50,
                margin: const EdgeInsets.symmetric(
                    horizontal: AppMargin.m10, vertical: AppMargin.m8),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    ColorManager.blue.withOpacity(.7),
                  )),
                  onPressed: () {
                    if (selectedLocation != null) {
                      widget.viewModel?.setCoordinates = selectedLocation!;
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Choices your home location',
                    style: AppTextStyles.homegenertalTextStyle(
                        context, ColorManager.white, FontSize.f16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          if (selectedLocation != null)
            GoogleMap(
              compassEnabled: true,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              onTap: _onMapTap,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: selectedLocation!,
                zoom: 15.0,
              ),
            ),
        ],
      ),
    );
  }
}