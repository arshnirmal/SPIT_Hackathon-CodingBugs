import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/coins_appbar.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';

class Redeem extends StatefulWidget {
  const Redeem({super.key});

  //  String title;
  //  String id;

  @override
  State<Redeem> createState() => RedeemState();
}

class RedeemState extends State<Redeem> {
  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [
      redeemCard(
          imageUrl: "assets/icons/voucher.jpeg",
          title: "Flipkart",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/amazonvoucher.jpeg",
          title: "Amazon",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/voucher.jpeg",
          title: "Flipkart",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/amazonvoucher.jpeg",
          title: "Amazon",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/voucher.jpeg",
          title: "Flipkart",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/amazonvoucher.jpeg",
          title: "Amazon",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/voucher.jpeg",
          title: "Flipkart",
          id: "1",
          coins: 50),
      redeemCard(
          imageUrl: "assets/icons/amazonvoucher.jpeg",
          title: "Amazon",
          id: "1",
          coins: 50),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colorss.quaternrtyColor,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colorss.primaryColor,
        actions: [
          CoinsAppBar().coins(context),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: categories.map((e) => e).toList(),
      )),
    );
  }
}

class redeemCard extends StatelessWidget {
  final imageUrl;

  String title;

  String id;
  int coins;

  redeemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.coins,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 15,
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          // onTap: () => detailedpage(context),
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Image.asset(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        top: 150,
                        left: 120,
                        child: Container(
                            color: const Color.fromARGB(162, 0, 0, 0),
                            width: 220,
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 26,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )))
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on),
                      Text(
                        "$coins required",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Icon(Icons.access_time),
                      Text(
                        "2 days left",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.currency_rupee),
                  //     Text(
                  //       "${affordability1}",
                  //       style: TextStyle(color: Colors.black, fontSize: 12),
                  //     )
                  //   ],
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
