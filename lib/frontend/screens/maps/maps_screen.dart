import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';
import 'package:spit_hackathon/frontend/screens/location/location_services.dart';
import 'package:spit_hackathon/frontend/shared/loader.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late Position position;
  late GoogleMapController googleMapController;
  Set<Marker> setOfMarkers = {};
  Set<Circle> setOfCircle = {};
  @override
  void initState() {
    super.initState();
  }

  initializeGoogleMap(GoogleMapController controller) async {
    googleMapController = controller;
  }

  addMarkers(Map<int, LatLng> data, LatLng from) {
    print(from);
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        GeoPoint geoPoint = doc["coordinates"] as GeoPoint;
        var marker = Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(geoPoint.latitude, geoPoint.longitude),
          infoWindow: InfoWindow(
              title: 'User with reptuation${doc["reputation"].toString()}'),
        );
        setOfMarkers.add(marker);
      }
    });
    for (var e in data.entries) {
      var marker = Marker(
        markerId: MarkerId(e.key.toString()),
        position: e.value,
        infoWindow: const InfoWindow(title: 'Another Anonymous User'),
      );
      setOfMarkers.add(marker);
    }
    setState(() {});
  }

  setCircle(LatLng center) {
    setOfCircle.add(
      Circle(
        circleId: const CircleId('user'),
        center: center,
        radius: 300,
        fillColor: Colors.green.withOpacity(0.3),
        strokeWidth: 1,
        strokeColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Community",
          style: TextStyle(
            color: Colorss.quaternrtyColor,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colorss.primaryColor,
      ),
      body: FutureBuilder(
        future: LocationServices.determinePosition(),
        builder: (context, snap) {
          if (snap.hasData) {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GoogleMap(
                      circles: setOfCircle,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          snapshot.data!.latitude,
                          snapshot.data!.longitude,
                        ),
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        initializeGoogleMap(controller);
                        Map<int, LatLng> testData = {
                          0: LatLng(
                            snapshot.data!.latitude,
                            snapshot.data!.longitude,
                          ),
                          1: const LatLng(19.0720, 72.8796),
                          2: const LatLng(19.0760, 72.8796),
                        };
                        addMarkers(testData,
                            LatLng(snap.data!.latitude, snap.data!.longitude));
                        setCircle(
                          LatLng(
                            snapshot.data!.latitude,
                            snapshot.data!.longitude,
                          ),
                        );
                      },
                      markers: setOfMarkers,
                    );
                  } else {
                    return loaderWidget(context);
                  }
                });
          } else {
            return loaderWidget(context);
          }
        },
      ),
    );
  }
}
