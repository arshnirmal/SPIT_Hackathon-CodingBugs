import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/mediaquery_contants.dart';
import '../constants/colors_constants.dart';

Widget loaderWidget(BuildContext context) {
  return Center(
    child: SizedBox(
      height: 0.1 * MediaQueryConstants.getWidth(context),
      width: 0.1 * MediaQueryConstants.getWidth(context),
      child: const CircularProgressIndicator(
        color: Colorss.primaryColor,
      ),
    ),
  );
}
