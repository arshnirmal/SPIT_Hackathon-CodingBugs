import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';
import 'package:spit_hackathon/frontend/constants/icons_constants.dart';
import 'package:spit_hackathon/frontend/screens/games.dart';
import 'package:spit_hackathon/frontend/screens/maps/maps_screen.dart';
import 'package:spit_hackathon/frontend/screens/posts/post_screen.dart';
import 'package:spit_hackathon/frontend/screens/profile/profile_screen.dart';
import 'package:spit_hackathon/frontend/shared/bottom_navigation.dart';

class Fragments extends StatefulWidget {
  const Fragments({Key? key}) : super(key: key);

  @override
  State<Fragments> createState() => _FragmentsState();
}

class _FragmentsState extends State<Fragments>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? indexInSettings;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  goToHome() {
    _tabController.animateTo(0);
    setState(() {
      tabIndex = 0;
    });
  }

  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: const [],
        //   title: const Text('Title'),
        //   centerTitle: true,
        //   elevation: 0.0,
        //   backgroundColor: Colorss.primaryColor,
        // ),
        // backgroundColor: const Color.fromRGBO(255, 255, 255, 0.94),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              PostPage(),
              MapsScreen(),
              Gamesfinal(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BottomNavigationBarShared().bottomNavbarDecoration(),
          height: 64,
          child: TabBar(
            onTap: (val) {
              setState(() {
                tabIndex = val;
              });
            },
            controller: _tabController,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colorss.teriaryColor.withOpacity(opacity),
            labelColor: Colors.white,
            tabs: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: SvgPicture.asset(
                      feedIcon,
                      color: tabIndex == 0
                          ? Colors.white
                          : Colorss.teriaryColor.withOpacity(opacity),
                    ),
                  ),
                  // Image.asset(
                  //     'assets/images/homeImageNavbarSelected.png')
                  // : Image.asset(
                  //     'assets/images/homeImageNavbarUnselected.png'),
                  const Text('Feed'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: Image.asset(
                      userIcon,
                      color: tabIndex == 1
                          ? Colors.white
                          : Colorss.teriaryColor.withOpacity(opacity),
                    ),
                  ),
                  const Text('Map'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: SvgPicture.asset(
                      gameIcon,
                      color: tabIndex == 2
                          ? Colors.white
                          : Colorss.teriaryColor.withOpacity(opacity),
                    ),
                  ),
                  const Text('Games'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: SvgPicture.asset(
                      profileIcon,
                      color: tabIndex == 3
                          ? Colors.white
                          : Colorss.teriaryColor.withOpacity(opacity),
                    ),
                  ),
                  const Text('Profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
