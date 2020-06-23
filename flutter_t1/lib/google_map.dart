import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MapView());

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
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

  void initState() {
    super.initState();
    markers.add(Marker(
        markerId: MarkerId("0"),
        position: BRAZIL,
        infoWindow:
            InfoWindow(title: "Brazil", snippet: "Num. de casos ativos")));
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
