import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(30.013492552269614, 31.212994217335012),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          northeast: LatLng(30.094453269704278, 31.33155580236429),
          southwest: LatLng(29.932365393897765, 31.034043873636804),
        ),
      ),
      initialCameraPosition: initialCameraPosition,
    );
  }
}
