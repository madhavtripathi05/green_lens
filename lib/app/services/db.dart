import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  // Stream<QuerySnapshot> getLotteries() => getStream('lotteries');

  // Future<List<Lottery>> getLotteriesList() async {
  // final snapshots = await firestore.collection('lotteries').get();
  // return snapshots.docs.map((doc) => Lottery.fromJson(doc.data())).toList();
  // }

  Future<void> upsert(String path, Map<String, dynamic> data) async {
    assert(path.isNotEmpty && data.isNotEmpty);
    await firestore.doc(path).set(data, SetOptions(merge: true));
  }

  Future<void> delete(String path) async {
    assert(path.isNotEmpty);
    await firestore.doc(path).delete();
  }
}
