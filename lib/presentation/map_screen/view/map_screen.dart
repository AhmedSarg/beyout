import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  // late Location location;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        zoom: 8, target: LatLng(30.47485747053768, 31.189873388919573));
    intiMarker();
    // location = Location();
    // upDateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  Set<Marker> marker = {};
  Set<Polyline> polylines = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          GoogleMap(
              zoomControlsEnabled: false,
              markers: marker,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                  northeast: LatLng(31.319573771437227, 34.24993346351709),
                  southwest: LatLng(22.170822181359323, 24.999445544988394))),
              initialCameraPosition: initialCameraPosition),
          Positioned(
            top: MediaQuery.of(context).size.height * .08,
            right: MediaQuery.of(context).size.width * .05,
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorManager.offwhite,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(AppSize.s8),
                      bottomLeft: Radius.circular(AppSize.s8))),
              child: IconButton(
                icon: SvgPicture.asset(
                  SVGAssets.location,
                  width: AppSize.s30,
                  height: AppSize.s30,
                ),
                onPressed: () {
                  googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(
                      LatLng(31.28740027455333, 30.02421947478106), 15));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PlaceModel> places = [
    PlaceModel(1, 'Home 1', LatLng(31.201648459655594, 30.040029939630163)),
    PlaceModel(2, 'Home 2', LatLng(31.175509030616524, 29.943899572305792)),
    PlaceModel(3, 'Home 3', LatLng(31.18872649811964, 30.010504183951966)),
    PlaceModel(4, 'Home 4', LatLng(31.239523127922276, 30.1327270795501)),
    PlaceModel(5, 'Home 5', LatLng(31.176390252524357, 30.079855377521692)),
  ];

  void intiMarker() {
    var myMarker = places
        .map((PlaceModel) => Marker(
            infoWindow: InfoWindow(
              snippet: PlaceModel.name,
            ),
            position: PlaceModel.latLng,
            markerId: MarkerId(PlaceModel.id.toString())))
        .toSet();
    marker.addAll(myMarker);
  }

//   Future<void> checkAndRequestLocationServes() async {
//     var isServecEnable = await location.serviceEnabled();
//     if (!isServecEnable) {
//       isServecEnable = await location.requestService();
//       if (!isServecEnable) {
// ////TODO :show error bar
//       }
//     }
//   }
//
//   Future<bool> checkAndRequestLocationPermission() async {
//     var permissionStatus = location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       await location.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   Future<void> getLocationData() async {
//     location.onLocationChanged.listen((locationData) {
//       var cameraPosition = CameraPosition(
//           target: LatLng(locationData.latitude!, locationData.longitude!));
//       googleMapController
//           ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     });
//   }
//
//   void upDateMyLocation() async {
//     await checkAndRequestLocationServes();
//     var hasPermission = await checkAndRequestLocationPermission();
//     if (hasPermission) {
//       getLocationData();
//     }
//   }
}
