import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  // read
  static Future<dynamic> getData(String tabel, String id) async {
    return (await FirebaseFirestore.instance.collection(tabel).doc(id).get())
        .data();
  }

  // set
  static Future<String?> insertData(
      String tabel, String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection(tabel).doc(id).set(data);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // update
  static Future<String?> updateData(
      String tabel, String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection(tabel).doc(id).update(data);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // delete
  static Future<String?> deleteData(String tabel, String id) async {
    try {
      await FirebaseFirestore.instance.collection(tabel).doc(id).delete();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
