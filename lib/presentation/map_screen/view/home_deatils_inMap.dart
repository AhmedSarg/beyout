
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMapHomeDetailsScreen extends StatefulWidget {
  const GoogleMapHomeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapHomeDetailsScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapHomeDetailsScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 8, target: LatLng(30.47485747053768, 31.189873388919573));
    super.initState();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Marker? tappedMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
          ),

        ],
      ),
    );
  }


}
