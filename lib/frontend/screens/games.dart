import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/coins_appbar.dart';

import '../constants/colors_constants.dart';
import 'dart:async';

class Gamesfinal extends StatefulWidget {
  const Gamesfinal({super.key});

  @override
  State<Gamesfinal> createState() => _GamesfinalState();
}

class _GamesfinalState extends State<Gamesfinal> {
  static const int maxsecconds = 60;
  Timer? timer;

  int seconds = maxsecconds;
  int? score;
  bool gamesover = false;
  List<ItemModel>? images;

  bool gameStarted = false;
  bool firstTime = true;
  @override
  void initState() {
    super.initState();
    score = 0;
    images = [
      ItemModel(
        name: "Foodwaste",
        value: "Biodegradable",
        image: "assets/images/foodwaste_biodegradable.jpeg",
      ),
      ItemModel(
        name: "Plastic",
        value: "Non Biodegradable",
        image: ("assets/images/plastic_nonbiodegradablewhichcanreuse.jpeg"),
      ),
      ItemModel(
        name: "Cardboard Box",
        value: "Biodegradable",
        image: "assets/images/box1.jpeg",
      ),
      ItemModel(
        name: "Plastic Bottles",
        value: "Non Biodegradable",
        image: "assets/images/plasticbottles.jpeg",
      )
    ];
  }

  List<ItemModel> images2 = [
    ItemModel(
      name: "Biodegradable",
      value: "Biodegradable",
      image: "assets/images/box1.jpeg",
    ),
    ItemModel(
      name: "Non Biodegradable",
      value: "Non Biodegradable",
      image: "assets/images/box1.jpeg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (gameStarted && firstTime) {
      firstTime = false;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) {
          if (seconds > 0) {
            setState(() {
              seconds--;
            });
          }
        },
      );
    }
    if (images!.isEmpty) {
      gamesover = true;
      timer?.cancel();
    }
    if (seconds == 0) {
      timer?.cancel();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Enjoy the Game!",
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
      backgroundColor: Colorss.secondaryColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              !gameStarted
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colorss.teriaryColor,
                          backgroundColor: Colorss.quaternrtyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(
                            () {
                              gameStarted = true;
                            },
                          );
                        },
                        child: const Text("Start"),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            score.toString(),
                            style: const TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Score",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Time left",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: seconds / maxsecconds,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    images!.isNotEmpty && seconds > 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: images2.map(
                                  (e) {
                                    return DragTarget(
                                      onAccept: (ItemModel receivedItem) {
                                        if (e.value == receivedItem.value) {
                                          setState(
                                            () {
                                              images!.remove(receivedItem);

                                              score = (score! + 10);

                                              e.accepting = false;
                                            },
                                          );
                                        } else {
                                          setState(
                                            () {
                                              print(images!.length);
                                              score = (score! - 10);
                                              e.accepting = false;
                                            },
                                          );
                                        }
                                      },
                                      onLeave: (receivedItem) {
                                        setState(
                                          () {
                                            print(images!.length);
                                            e.accepting = false;
                                          },
                                        );
                                      },
                                      onWillAccept: (receivedItem) {
                                        setState(
                                          () {
                                            print(images!.length);
                                            e.accepting = true;
                                          },
                                        );
                                        return true;
                                      },
                                      builder: ((
                                        context,
                                        candidateData,
                                        rejectedData,
                                      ) {
                                        return Column(
                                          children: [
                                            Image.asset(e.image),
                                            Text(e.name),
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                ).toList(),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: images!.map(
                                    (e) {
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        child: gameStarted
                                            ? Draggable<ItemModel>(
                                                data: e,
                                                childWhenDragging: SizedBox(
                                                  height: 150,
                                                  child: Image.asset(
                                                    e.image,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                feedback: SizedBox(
                                                  height: 150,
                                                  child: Image.asset(
                                                    e.image,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 150,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.asset(e.image),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const Text(
                                "GameOver",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colorss.teriaryColor,
                                      backgroundColor: Colorss.quaternrtyColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text("Restart"),
                                    onPressed: () {
                                      // initGame();

                                      setState(
                                        () {
                                          seconds = 60;
                                          score = 0;
                                          firstTime = true;
                                          gameStarted = true;
                                          images = [
                                            ItemModel(
                                              name: "Foodwaste",
                                              value: "Biodegradable",
                                              image:
                                                  "assets/images/foodwaste_biodegradable.jpeg",
                                            ),
                                            ItemModel(
                                              name: "Plastic",
                                              value: "Non Biodegradable",
                                              image:
                                                  ("assets/images/plastic_nonbiodegradablewhichcanreuse.jpeg"),
                                            ),
                                            ItemModel(
                                              name: "Cardboard Box",
                                              value: "Biodegradable",
                                              image: "assets/images/box1.jpeg",
                                            ),
                                            ItemModel(
                                              name: "Plastic Bottles",
                                              value: "Non Biodegradable",
                                              image:
                                                  "assets/images/plasticbottles.jpeg",
                                            )
                                          ];
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final String image;
  bool accepting;

  ItemModel(
      {required this.name,
      required this.value,
      required this.image,
      this.accepting = false});
}
