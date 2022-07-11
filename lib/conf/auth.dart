import 'package:firebase_auth/firebase_auth.dart';
import '../conf/firestore.dart';

class Auth {
  // daftar + create database profile
  static Future<String?> register(String mail, String pwd, String name) async {
    try {
      UserCredential newAccount = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      Map<String, dynamic> data = {
        "gender": "",
        "telepon": "",
        "saldo": 0,
        "tanggal_lahir": "",
        "alamat": "",
        "transaksi": [],
        "wishlist": [],
        "keranjang": [],
      };
      print(newAccount.user!.uid);
      await newAccount.user!.updateDisplayName(name);
      await Firestore.insertData("users", newAccount.user!.uid, data);
      return null;
    } on FirebaseAuthException catch (e) {
      return "${e.code}: ${e.message}";
    }
  }

  // signin
  static Future<String?> signin(String mail, String pwd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      return null;
    } on FirebaseAuthException catch (e) {
      return "${e.code}: ${e.message}";
    }
  }

  // signout
  static Future<String?> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return "${e.code}: ${e.message}";
    }
  }
}
