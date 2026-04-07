import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/place_model.dart';

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

   // initMarkers();
   // initPolyLines();
    //initPolygon();
    initCircle();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circle= {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: initialCameraPosition,
          polygons: polygons,
          circles: circle,
          // markers: markers,
          // polylines: polylines,
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
        // Positioned(
        //   bottom: 16,
        //   right: 16,
        //   left: 16,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       CameraPosition newCameraPosition = CameraPosition(
        //         zoom: 12,
        //         target: LatLng(31.200515566474515, 29.961085975707423),
        //       );
        //       googleMapController.animateCamera(
        //         CameraUpdate.newCameraPosition(newCameraPosition),
        //       );
        //     },
        //     child: Text('Change Location'),
        //   ),
        // ),
      ],
    );
  }
  void initPolygon() {
    Polygon polygon = Polygon(
      fillColor: Colors.black.withOpacity(.5),
      strokeWidth: 5,
      points: [
        LatLng(30.0224782936375, 31.140935337219926),
        LatLng(30.019158979991634, 31.145308358373715),
        LatLng(30.01795799491682, 31.14170591363469),
        LatLng(30.02012642961292, 31.137217306018687),
      ],
        polygonId: PolygonId('1'),
    );

    polygons.add(polygon);
  }

  void initCircle() {
    Circle myCircle = Circle(
      strokeColor: Colors.red,
      strokeWidth: 4,
      radius: 1000,
      center: LatLng(30.017974675364673, 31.14164812040358),
        circleId: CircleId('1'),
    );

    circle.add(myCircle);
  }
  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }

  void initMarkers() {
    var myMarkers = placeModel
        .map(
          (e) => Marker(
            infoWindow: InfoWindow(title: e.name),
            position: e.latLng,
            markerId: MarkerId(e.id.toString()),
          ),
        )
        .toSet();

    markers.addAll(myMarkers);
  }

  void initPolyLines() {
    Polyline myPolyLines = const Polyline(
      patterns: [
        PatternItem.dot
      ],
      width: 5,
      zIndex: 2,
      color: Colors.red,
      startCap: Cap.roundCap,
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.00601664824596, 31.122438726749444),
        LatLng(30.01612992354812, 31.163207463611027),
        LatLng(30.03805256711961, 31.119404926979477),
        LatLng(30.045849051158623, 31.139222459444863),
      ],
    );

    Polyline myPolyLines2 = const Polyline(
      patterns: [
        PatternItem.dot
      ],
      width: 5,
      zIndex: 1,
      color: Colors.black,
      startCap: Cap.roundCap,
      polylineId: PolylineId('2'),
      points: [
        LatLng(29.997864816146, 31.197290531043535),
        LatLng(29.999797459343498, 31.172914616434714),
        LatLng(30.014959968945686, 31.113541239918316),
        LatLng(30.018508702043626, 31.107039565511204),
      ],
    );

    polylines.add(myPolyLines);
    polylines.add(myPolyLines2);
  }
}




