import 'dart:io';

import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:green_lens/app/models/post.dart';
import 'package:http/http.dart' as http;

class DBService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadFile(File _image, String uid) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/$uid/${DateTime.now()}.jpg');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => print('File uploaded'));

    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  /// [UNIVERSAL METHODS]
  Future<Map<String, dynamic>> getData(String collectionPath) async {
    assert(collectionPath.isNotEmpty);
    final doc = await firestore.doc(collectionPath).get();
    return doc.data();
  }

  Future<Map<String, dynamic>> getDataWhere(
      String collectionPath, String key, dynamic value) async {
    assert(collectionPath.isNotEmpty);
    final snapshot = await firestore
        .collection(collectionPath)
        .where(key, isEqualTo: value)
        .get();
    return snapshot?.docs?.first?.data() ?? null;
  }

  Stream<QuerySnapshot> getStream(String collectionPath) {
    assert(collectionPath.isNotEmpty);
    return firestore.collection(collectionPath).snapshots();
  }

  Stream<QuerySnapshot> getPosts() => getStream('posts');

  Future<List<Post>> getPostsList() async {
    final snapshots = await firestore.collection('posts').get();
    return snapshots.docs.map((doc) => Post.fromJson(doc.data())).toList();
  }

  Future<void> upsert(String path, Map<String, dynamic> data) async {
    assert(path.isNotEmpty && data.isNotEmpty);
    await firestore.doc(path).set(data, SetOptions(merge: true));
  }

  Future<void> delete(String path) async {
    assert(path.isNotEmpty);
    await firestore.doc(path).delete();
  }

  ///* Flask API methods

  Future<String> predict(File image, String crop) async {
    // final data = jsonEncode({"image": image});
    // final res = await http
    //     .post(Uri.http('localhost:5000', '/api/$crop-prediction'), body: data);
    // open a byte stream

    var stream = new http.ByteStream(image.openRead());
    stream.cast();
    var length = await image.length();
    var uri = Uri.parse('http://localhost:5000/api/$crop-prediction');
    var request = new http.MultipartRequest('POST', uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(image.path));
    request.files.add(multipartFile);
    var response = await request.send();
    String res = await response.stream.bytesToString();
    return res;
  }
}
