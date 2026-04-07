import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(30.013492552269614, 31.212994217335012),
    );

    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: markers,
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     northeast: LatLng(30.094453269704278, 31.33155580236429),
          //     southwest: LatLng(29.932365393897765, 31.034043873636804),
          //   ),
          // ),
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              CameraPosition newCameraPosition = CameraPosition(
                zoom: 12,
                target: LatLng(31.200515566474515, 29.961085975707423),
              );
              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(newCameraPosition),
              );
            },
            child: Text('Change Location'),
          ),
        ),
      ],
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }

  void initMarkers() {
    var myMarkers = Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.013492552269614, 31.212994217335012),
    );
    markers.add(myMarkers);
  }
}


