import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps/utils/location_service.dart';

class LiveLocations extends StatefulWidget {
  const LiveLocations({super.key});

  @override
  State<LiveLocations> createState() => _LiveLocationsState();
}

class _LiveLocationsState extends State<LiveLocations> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late LocationService locationService;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(30.013492552269614, 31.212994217335012),
    );
    locationService = LocationService();
    myLocation();
    super.initState();
  }

  Set<Marker> markers = {};

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
        ),
      ],
    );
  }

  void myLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission = await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData(((locationData){
        var cameraPosition = CameraPosition(
          zoom: 15,
          target: LatLng(locationData.latitude!, locationData.longitude!),
        );
        var myLocationMarkers =  Marker(
          markerId: MarkerId('1'),
          position: LatLng(locationData.latitude!, locationData.longitude!),
        );
        markers.add(myLocationMarkers);
        googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        );
      }));
    } else {}
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');

    googleMapController!.setMapStyle(nightMapStyle);
  }
}
