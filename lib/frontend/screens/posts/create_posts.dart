import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

bool test = false;

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _article = TextEditingController();
  final TextEditingController _image = TextEditingController();
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Community",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colorss.quaternrtyColor,
          ),
          onPressed: () {},
        ),
        backgroundColor: Colorss.primaryColor,
        actions: [
          TextButton(
              onPressed: () {
                final name = _name.text;
                final article = _article.text;
                final image = _image.text;
                createPost(name: name, article: article, image: image);
                Navigator.pushNamed(context, '/posts');
              },
              child: const Text(
                "Post",
              )),
        ],
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   title: Center(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         IconButton(
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //           icon: const Icon(Icons.close),
      //         ),
      //         TextButton(
      //           onPressed: () async {
      //             final name = _name.text;
      //             final article = _article.text;
      //             final image = _image.text;
      //             await createPost(name: name, article: article, image: image);
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const PostPage(),
      //               ),
      //             );
      //           },
      //           child: const Text("Post"),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: ListView(children: [
          Column(
            children: [
              const Text("What's in your mind"),
              //TextEditing field
              TextFormField(
                maxLines: null,
                controller: _article,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () async {
                  test = true;
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Text("Add Image"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  test = true;
                },
                child: const Row(
                  children: [
                    Icon(Icons.video_camera_back_outlined),
                    Text("Add video"),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future createPost({
    required String name,
    required String image,
    required String article,
  }) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc();
    String id = docPost.id;
    final post = Post(
      id = docPost.id,
      name: name,
      article: article,
      // time: Timestamp.now(),
      image: "",
    );
    final json = post.toJson();
    await docPost.set(json);
  }
}

class Post {
  final String image;
  final String name;
  final String article;
  // final Timestamp time;

  Post(
    String s, {
    required this.image,
    required this.name,
    required this.article,
    // required this.time,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'article': article,
        'image': '',
        'time': Timestamp.now(),
      };
}
