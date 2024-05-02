import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapHomeDetailsScreen extends StatefulWidget {
  const GoogleMapHomeDetailsScreen({Key? key, this.coordinates}) : super(key: key);
  final GeoPoint? coordinates;

  @override
  State<GoogleMapHomeDetailsScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapHomeDetailsScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;

  @override
  void initState() {
    if (widget.coordinates != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(widget.coordinates!.latitude, widget.coordinates!.longitude),
        zoom: 19,
      );
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(30.47485747053768, 31.189873388919573),
        zoom: 8,
      );
    }
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
