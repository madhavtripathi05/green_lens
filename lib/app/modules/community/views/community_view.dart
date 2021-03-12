import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:get/get.dart';
import 'package:green_lens/app/models/post.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'readmore.dart';
import '../controllers/community_controller.dart';

final cc = CommunityController.to;

class CommunityView extends GetView<CommunityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => Stack(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SearchBar().paddingAll(10),
                  if (cc.posts.length > 0)
                    ...cc.posts.map((p) => PostCard(p)).toList().reversed,
                  if (cc.posts.length == 0)
                    Center(child: Text('No posts found!')),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed('/new-post'),
            backgroundColor: Colors.green,
            label: Text('Add Post')));
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: cc.searchController,
              decoration: InputDecoration(
                  hintText: "e.g. Mango", border: InputBorder.none),
            ),
          ),
          InkWell(
            onTap: cc.searchController.clear,
            child: Icon(CupertinoIcons.clear_circled_solid),
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard(this.post);
  @override
  Widget build(BuildContext context) {
    final uploaded =
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(post.date));
    final timeLeftInSeconds = DateTime.now().difference(uploaded).inSeconds;
    final time = DateTime.now().subtract(Duration(seconds: timeLeftInSeconds));
    return GestureDetector(
      onDoubleTap: () => cc.updateLike(post),
      onLongPress: () =>
          Share.share('check out my post on green lens', subject: post.content),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(post.profile ??
                  'https://developers.google.com/web/images/contributors/no-photo.jpg'),
            ),
            title: Text(
              post.uploader,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: post.id.split('@').first == cc.currentUser.uid
                ? PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return {'Delete', 'Edit'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: ListTile(
                            title: Text(choice),
                            onTap: () => choice == "Edit"
                                ? cc.editPost(post)
                                : cc.deletePost(post),
                            leading: Icon(
                                choice == "Edit" ? Icons.edit : Icons.delete),
                          ),
                        );
                      }).toList();
                    },
                  )
                : Text(''),
          ),
          if (post.imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: post.imageUrl,
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
          Text('${post.title}').paddingAll(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                  label: Text(
                    '${post.likes.length ?? 0}',
                    style: TextStyle(color: Colors.green),
                  ),
                  icon: post.likes.contains(cc.currentUser.uid)
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 28,
                        )
                      : Icon(
                          FlutterIcons.heart_faw5,
                          color: Colors.green,
                        ),
                  onPressed: () => cc.updateLike(post)),
              TextButton.icon(
                  label: Text(
                    '${post.comments.length ?? 0}',
                    style: TextStyle(color: Colors.green),
                  ),
                  icon: post.comments.any((c) => c.id == cc.currentUser.uid)
                      ? Icon(FlutterIcons.comment_text_mco, color: Colors.green)
                      : Icon(
                          FlutterIcons.comment_alt_faw5,
                          color: Colors.green,
                        ),
                  onPressed: () => cc.updateComments(post)),
              IconButton(
                  icon: Icon(
                    FlutterIcons.share_faw,
                    color: Colors.green,
                  ),
                  onPressed: () => Share.share(
                      'check out my post on green lens',
                      subject: post.content)),
            ],
          ),
          ReadMoreText(
            '${post.uploader}: ${post.content}',
            textAlign: TextAlign.start,
            trimLines: 1,
            colorClickableText: Colors.green,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: 'less',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ).paddingAll(8),
          if (post.comments.length > 0)
            Container(
              height: 50,
              child: ListView(physics: BouncingScrollPhysics(), children: [
                ...post.comments.map(
                  (c) => Row(
                    children: [
                      if (post.comments.any((c) => c.id == cc.currentUser.uid))
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                            onPressed: () => cc.updateComments(post, true)),
                      Expanded(
                        child: ReadMoreText(
                          '${c.by}: ${c.content}',
                          textAlign: TextAlign.start,
                          trimLines: 1,
                          colorClickableText: Colors.green,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'more',
                          trimExpandedText: 'less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ).paddingAll(8),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          Text(
            '${timeago.format(time)}',
            style: TextStyle(fontSize: 12),
          ).paddingAll(8),
        ],
      ),
    );
  }
}
