import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'model/event_model.dart';

class GoogleMapsTab extends StatefulWidget {
  const GoogleMapsTab({super.key});

  @override
  State<GoogleMapsTab> createState() => _GoogleMapsTabState();
}

class _GoogleMapsTabState extends State<GoogleMapsTab> {
  String? _style;
  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString(
      'assets/map_style/map_style.json',
    );
    setState(() {
      _style = style;
    });
  }

  late GoogleMapController _controller;
  Location location = Location();
  LatLng? initLocation;

  @override
  void initState() {
    _loadMapStyle();
    initializeMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            // zoomGesturesEnabled: true,
            onCameraMove: (position) {
              print('position=> $position');
            },
            trafficEnabled: true,
            // liteModeEnabled: true,
            onMapCreated: (controller) {
              _controller = controller;
            },
            initialCameraPosition: CameraPosition(
              target: initLocation ?? LatLng(0, 0),
              zoom: 10,
            ),
            // mapType: MapType.hybrid,
            polylines: {
              Polyline(
                polylineId: const PolylineId('1'),
                color: Colors.red,
                width: 5,
                points: const [
                  LatLng(30.0444, 31.2357),
                  LatLng(30.1700, 30.9500),
                  LatLng(30.5000, 30.3000),
                  LatLng(30.8000, 30.0000),
                  LatLng(31.0000, 29.8000),
                  LatLng(31.2001, 29.9187),
                ],
              ),
            },
            markers: Event.egyptEvents
                .map(
                  (event) => Marker(
                onTap: () {
                  _updateCameraPosition(
                    LatLng(event.latitude, event.longitude),
                  );
                },

                infoWindow: InfoWindow(title: event.title),
                markerId: MarkerId(event.id),
                position: LatLng(event.latitude, event.longitude),
              ),
            )
                .toSet(),
            style: _style,
          ),
          Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 55,
                  left: 20,
                  right: 20,
                ),
                child: SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          Event.egyptEvents[index].imageUrl ?? '',
                          width: 190,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 10),
                    itemCount: Event.egyptEvents.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _updateCameraPosition(LatLng latLng) async {
    await _controller.animateCamera(
      duration: Duration(milliseconds: 500),
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 20)),
    );
  }

  Future<void> initializeMap() async {
    bool servicesEnabled = await location.serviceEnabled();
    if (!servicesEnabled) {
      servicesEnabled = await location.requestService();
      if (!servicesEnabled) {
        //error dialog
        return;
      }
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        //error dialog
        return;
      }
    }
    final locationData = await location.getLocation();
    setState(() {
      initLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }
}
