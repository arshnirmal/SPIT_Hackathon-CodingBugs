import 'package:flutter/material.dart';

class CoinsAppBar {
  Widget coins(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/redeem');
      },
      child: const SizedBox(
        width: 64.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
