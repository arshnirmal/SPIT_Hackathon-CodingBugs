import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {
  String id;
  String name;
  double reputation;
  String email;
  String phone;
  LatLng coordinates;
  String profileImageUrl;
  // List<Post> listOfPosts;
  // QuizResult quizResult;
  List<String> track;

  UserModel({
    required this.id,
    required this.name,
    required this.reputation,
    required this.email,
    required this.phone,
    required this.coordinates,
    required this.profileImageUrl,
    // required this.listOfPosts,
    // required this.quizResult,
    required this.track,
  });

  static UserModel fromMap(Map<String, dynamic> data) {
    late UserModel result = UserModel(
        id: "id",
        name: "name",
        reputation: 0,
        email: "email",
        phone: "phone",
        coordinates: LatLng(19.000, 72.000),
        profileImageUrl: "profileImageUrl",
        track: []);
    for (var e in data.entries) {
      switch (e.key) {
        case 'id':
          result.id = e.value;
          break;
        case 'name':
          result.name = e.value;
          break;
        case 'reputation':
          result.reputation = e.value;
          break;
        case 'email':
          result.email = e.value;
          break;
        case 'phone':
          result.phone = e.value;
          break;
        case 'coordinates':
          result.coordinates = e.value; // TODO
          break;
        case 'profileImageUrl':
          result.profileImageUrl = e.value;
          break;
        case 'track':
          result.track = e.value;
          break;
        case 'id':
          result.id = e.value;
          break;

        default:
      }
    }
    return result;
  }
}
