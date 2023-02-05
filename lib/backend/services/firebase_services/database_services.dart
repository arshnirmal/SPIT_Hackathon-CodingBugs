import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spit_hackathon/backend/models/user_model.dart';

class DatabaseServices {
  FirebaseFirestore firebaseFirestore =
      FirebaseFirestore.instanceFor(app: Firebase.app('mainFirebaseAccount'));

  getUserData() async {
    return await firebaseFirestore.collection('users').get();
  }

  setUserData(UserModel user) async {
    await firebaseFirestore.collection('users').doc(user.id).update({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'profileImageUrl': user.profileImageUrl,
      'coordinates': user.coordinates,
      'reputation': user.reputation,
      'track': user.track,
      'id': user.id,
    });
  }

  double distanceBetweenTwoCoordinates(LatLng from, LatLng to) {
    var R = 6371.071; // Radius of the Earth in miles
    var rlat1 = from.latitude * (math.pi / 180); // Convert degrees to radians
    var rlat2 = to.latitude * (math.pi / 180); // Convert degrees to radians
    var difflat = (rlat2 - rlat1); // Radian difference (latitudes)
    var difflon = (to.longitude - from.longitude) *
        (math.pi / 180); // Radian difference (longitudes)

    var d = 2 *
        R *
        math.asin(math.sqrt(math.sin(difflat / 2) * math.sin(difflat / 2) +
            math.cos(rlat1) *
                math.cos(rlat2) *
                math.sin(difflon / 2) *
                math.sin(difflon / 2)));
    return d;
  }

  // Stream<List<UserModel>> getNearbyUsers(LatLng currentUserCoordinate) async {
  //   firebaseFirestore.collection('users').snapshots().map((event) {
  //     List<UserModel> result = [];
  //     for (var element in event.docs) {
  //       distanceBetweenTwoCoordinates(
  //                   currentUserCoordinate, element['coordinate']) <=
  //               300.0
  //           ? result.add(UserModel.fromMap(element.data()))
  //           : null;
  //     }
  //     return result;
  //   });
  // }
}
