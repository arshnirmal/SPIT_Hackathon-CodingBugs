import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';
import 'package:spit_hackathon/frontend/constants/mediaquery_contants.dart';

class AppbarShared {
  double appbarHeight = 72;
  PreferredSize appBarShared(BuildContext context,
      {Widget? title,
      Widget? action,
      Widget? leading,
      Function? actionTapped,
      Function? leadingTapped}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(appbarHeight),
        child: Container(
          width: MediaQueryConstants.getWidth(context),
          decoration: BoxDecoration(
              color: Colorss.primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    leadingTapped != null ? leadingTapped() : () {};
                  },
                  child: leading,
                ),
                title ?? Container(),
                GestureDetector(
                  onTap: () {
                    actionTapped != null ? actionTapped() : () {};
                  },
                  child: action ?? Container(),
                ),
              ]),
        ));
  }
}
