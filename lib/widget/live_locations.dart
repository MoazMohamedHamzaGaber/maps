import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocations extends StatefulWidget {
  const LiveLocations({super.key});

  @override
  State<LiveLocations> createState() => _LiveLocationsState();
}

class _LiveLocationsState extends State<LiveLocations> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late Location location ;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 12,
      target: LatLng(30.013492552269614, 31.212994217335012),
    );
    location =Location();
    checkAndRequestLocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
        ),
      ],
    );
  }

  void checkAndRequestLocationService() async{
   var isServiceEnabled = await location.serviceEnabled();

   if(!isServiceEnabled){
     isServiceEnabled = await location.requestService();
     if(!isServiceEnabled){

     }
   }
  }


  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }
}

