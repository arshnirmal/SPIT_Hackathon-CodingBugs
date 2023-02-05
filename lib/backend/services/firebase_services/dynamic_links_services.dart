import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:spit_hackathon/backend/constants/dynamic_links_constants.dart';

class DynamicLinksServices {
  static final FirebaseDynamicLinks firebaseDynamicLinks =
      FirebaseDynamicLinks.instance;
  // background state

  static void backgroundStateDynamicLink(BuildContext context) {
    firebaseDynamicLinks.onLink.listen((dynamicData) {
      Navigator.pushNamed(context, dynamicData.link.path,);
    }).onError((error) {
      print(error);
    });
  }

  static Future<Uri> createDynamicLinks({bool short = false}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(kUriPrefix + kHomePageEndpoint),
      uriPrefix: kUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: "com.example.spit_hackathon",
        minimumVersion: 0,
      ),
    );

    if (short) {
      ShortDynamicLink shortLink =
          await firebaseDynamicLinks.buildShortLink(parameters);
      return shortLink.shortUrl;
    }
    return firebaseDynamicLinks.buildLink(parameters);
  }
}
