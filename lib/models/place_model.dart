import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> placeModel = [
  PlaceModel(
    id: 1,
    name: 'كشري القدوة',
    latLng: LatLng(30.01593153395247, 31.142244006129758),
  ),
  PlaceModel(
    id: 2,
    name: 'مستوصف المنشية',
    latLng: LatLng(30.015973244419516, 31.139203221662175),
  ),
  PlaceModel(
    id: 3,
    name: 'مسجد المدينة المنوره',
    latLng: LatLng(30.011437128279685, 31.151625278104536),
  ),
];
