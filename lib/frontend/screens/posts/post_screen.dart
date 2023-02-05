import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/coins_appbar.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';
import 'package:spit_hackathon/frontend/constants/mediaquery_contants.dart';
import 'package:spit_hackathon/frontend/shared/loader.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

Set<String> month = {
  "Jan",
  "Feb",
  "Mar",
  "April",
  "May",
  "June",
  "July",
  "Aug",
  "Sep",
  "Nov",
  "Dec"
};

class _PostPageState extends State<PostPage> {
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  // For Deleting User
  CollectionReference users = FirebaseFirestore.instance.collection('posts');
  // Future<void> deleteUser(id) {
  //   print("User Deleted $id");
  // return users
  //     .doc(id)
  //     .delete()
  //     .then((value) => print('User Deleted'))
  //     .catchError((error) => print('Failed to Delete user: $error'));
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // DateTime dateTime = DateTime(hashCode);
        if (!snapshot.hasData) {
          return loaderWidget(context);
        }
        if (snapshot.hasError) {
          print('Something went Wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List storedocs = [];
        final List booleanList = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          booleanList.add(false);
        }).toList();

        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/createost');
          //   },
          //   backgroundColor: Colorss.primaryColor,
          //   child: const Icon(Icons.add),
          // ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 64.0,
                backgroundColor: Colorss.primaryColor,
                floating: true,
                centerTitle: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                    'The Eco-Feed!',
                    textScaleFactor: 0.5,
                    style: TextStyle(
                      color: Colorss.quaternrtyColor,
                      fontSize: 25.0,
                    ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  CoinsAppBar().coins(context),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Timestamp timeStamp = storedocs[index]['time'];
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(32.0),
                          color: Colorss.teriaryColor,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          storedocs[index]['image'] != null
                                              ? NetworkImage(
                                                  storedocs[index]['image'],
                                                )
                                              : null,
                                      radius: 24.0,
                                    ),
                                    Text(
                                      storedocs[index]['name'],
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      // dateTime.toString(),
                                      timeStamp.toDate().day.toString() +
                                          " " +
                                          month.elementAt(
                                              timeStamp.toDate().month - 1) +
                                          " " +
                                          timeStamp.toDate().hour.toString() +
                                          ':' +
                                          timeStamp.toDate().minute.toString(),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colorss.teriaryColor,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      booleanList[index] = !booleanList[index];
                                    });
                                  },
                                  child: Text(
                                    storedocs[index]['article'],
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.left,
                                    // maxLines: 5,
                                    style: TextStyle(
                                      overflow: booleanList[index]
                                          ? TextOverflow.ellipsis
                                          : TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                storedocs[index]['image'] == ""
                                    ? Container()
                                    : SizedBox(
                                        width: double.infinity,
                                        child: Image.network(
                                          storedocs[index]['image'],
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                const Divider(
                                  color: Colorss.teriaryColor,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.flash_on),
                                      SizedBox(
                                        width: MediaQueryConstants.getWidth(
                                                context) *
                                            0.2,
                                      ),
                                      const Icon(Icons.delete_forever_sharp),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // onPressed: () => {
                          //   // Navigator.push(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) => ProfilePage(
                          //   //       id: storedocs[i]['id'],
                          //   //     ),
                          //   //   ),
                          //   // )
                          // },
                        ),
                      ),
                    );
                  },
                  childCount: storedocs.length,
                ),
              ),
            ],
            scrollDirection: Axis.vertical,
          ),
        );
      },
    );
  }
}
