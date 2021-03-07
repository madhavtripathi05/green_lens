import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/post.dart';
import 'package:green_lens/app/services/auth.dart';
import 'package:green_lens/app/services/db.dart';

class CommunityController extends GetxController {
  static final to = Get.find<CommunityController>();
  TextEditingController searchController;
  final currentUser = AuthService().auth.currentUser;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final commentController = TextEditingController();
  final db = DBService();
  final posts = <Post>[].obs;
  final tempPosts = <Post>[].obs;

  void search(String query) async {
    posts.assignAll(tempPosts.where((p) {
      bool titleContains = p.title.toLowerCase().contains(query.toLowerCase());
      bool descriptionContains =
          p.content.toLowerCase().contains(query.toLowerCase());

      return (titleContains || descriptionContains);
    }));
  }

  void _onTextChanged() => search(searchController.text);

  Future<void> updateLike(Post post) async {
    String uid = currentUser.uid;
    bool liked = post.likes.contains(uid);
    if (liked) {
      post.likes.remove(uid);
      db.upsert('posts/${post.id}', {'likes': post.likes});
    } else {
      db.upsert('posts/${post.id}', {
        'likes': [...post.likes, uid]
      });
    }
  }

  Future<void> deletePost(Post post) async {
    Get.back();
    await db.delete('posts/${post.id}');
  }

  Future<void> editPost(Post post) async {
    titleController.text = post.title;
    contentController.text = post.content;

    Get.back();
    Get.defaultDialog(
        title: "Edit Post",
        content: Column(
          children: [
            Text('Title').paddingAll(8),
            TextField(
              controller: titleController,
            ).paddingAll(8),
            Text('content').paddingAll(8),
            TextField(controller: contentController).paddingAll(8),
            TextButton.icon(
                onPressed: () async {
                  await DBService().upsert('posts/${post.id}', {
                    'title': titleController.text,
                    'content': contentController.text
                  });
                  Get.back();
                },
                icon: Icon(Icons.check),
                label: Text('Update'))
          ],
        ));
  }

  Future<void> updateComments(Post post, [bool delete = false]) async {
    bool commented = post.comments.any((c) => c.id == currentUser.uid);
    if (commented && delete) {
      post.comments.removeWhere((c) => c.id == currentUser.uid);
      db.upsert('posts/${post.id}', {'comments': post.comments});
      return;
    }
    if (commented) {
      Get.rawSnackbar(
          title: 'Warning!', message: 'You can only add one comment');
      return;
    }
    Get.defaultDialog(
      title: 'Add your Comment',
      content: Column(
        children: [
          TextField(controller: commentController).paddingAll(8),
          TextButton(
              child: Text('Comment'),
              onPressed: () {
                if (commentController.text.length > 0) {
                  db.upsert('posts/${post.id}', {
                    'comments': [
                      ...post.comments.map((c) => c.toJson()),
                      Comment(
                              by: currentUser.displayName,
                              id: currentUser.uid,
                              content: commentController.text,
                              date: '${DateTime.now().millisecondsSinceEpoch}')
                          .toJson()
                    ]
                  });
                  commentController.clear();
                  Get.back();
                } else {
                  Get.rawSnackbar(
                      title: 'Warning!',
                      message: 'Enter at least 2 characters');
                }
              })
        ],
      ),
    );
  }

  @override
  void onInit() async {
    searchController = TextEditingController()..addListener(_onTextChanged);
    posts.bindStream(db.getPosts().map(
        (list) => list.docs.map((doc) => Post.fromJson(doc.data())).toList()));
    tempPosts.bindStream(db.getPosts().map(
        (list) => list.docs.map((doc) => Post.fromJson(doc.data())).toList()));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
