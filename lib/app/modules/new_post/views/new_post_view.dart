import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/modules/new_post/controllers/new_post_controller.dart';

class NewPostView extends StatelessWidget {
  final nc = NewPostController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('New Post'),
          actions: [
            nc.submitting.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  )
                : TextButton.icon(
                    label: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: nc.onSubmit,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                if (nc.imageSelected.value)
                  Column(
                    children: [
                      ClipRRect(
                        child: Image.file(nc.image,
                            height: 100, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      nc.imageUploaded.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Image Uploaded!',
                                style: TextStyle(color: Colors.green),
                              ),
                            )
                          : nc.submitting.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(''),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Colors.white,
                        ),
                        elevation: 8,
                        onPressed: () {
                          nc.getImage(true);
                        },
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder(),
                      ),
                      RawMaterialButton(
                        fillColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        elevation: 8,
                        onPressed: () {
                          nc.getImage(false);
                        },
                        padding: EdgeInsets.all(15),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Text('Enter a title'),
                TextFormField(controller: nc.titleController, maxLength: 30),
                SizedBox(height: 10),
                Text('Enter description'),
                TextFormField(controller: nc.contentController, maxLines: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
