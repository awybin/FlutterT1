import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_t1/repository/corona_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

void main() => runApp(MapView());

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map View',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();
  static LatLng BRAZIL = LatLng(-14.24, -51.93);
  var fmt = NumberFormat.compactLong(locale: 'pt-br');

  double _proportionalHue(int value) {
    if (value <= 10000) return BitmapDescriptor.hueGreen;
    if (value <= 50000) return BitmapDescriptor.hueCyan;
    if (value <= 100000) return BitmapDescriptor.hueYellow;
    if (value <= 500000) return BitmapDescriptor.hueOrange;
    if (value <= 1000000) return BitmapDescriptor.hueViolet;
    return BitmapDescriptor.hueRed;
  }

  void initState() {
    super.initState();
    _addMarkers();
  }

  _addMarkers() async {
    var newMarkers = Set<Marker>();
    var data = await CoronaRepository.fetchAlbum();
    data.countries.forEach((element) {
      newMarkers.add(Marker(
          markerId: MarkerId(element.country),
          position: element.latlng,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              _proportionalHue(element.totalConfirmed)),
          infoWindow: InfoWindow(
              title: element.country,
              snippet:
                  '${fmt.format(element.totalConfirmed)} casos confirmados')));
    });

    setState(() {
      markers = newMarkers;
    });
  }

  static final CameraPosition _brazilLocation = CameraPosition(
    target: BRAZIL,
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        initialCameraPosition: _brazilLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }
}
