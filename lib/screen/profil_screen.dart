import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../conf/firestore.dart';
import '../conf/navigatebar.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  User? _user;
  Map<String, dynamic>? _listData;
  bool _showData = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration.zero, () async {
      _listData = await Firestore.getData('users', (_user?.uid).toString());
      setState(() {
        _showData = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _user = null;
    _listData!.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget _customCard(IconData valueIcon, String? valueText) {
      if (valueText.toString() == "") return const SizedBox.shrink();
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(valueIcon),
          title: Text(
            valueText.toString(),
            style: const TextStyle(fontSize: 15),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.pink, Colors.brown])),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).viewPadding.top),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pushNamed(
                                      context, "/profil_edit", arguments: {
                                    "data": _listData,
                                    "user": _user
                                  }),
                              splashRadius: 1,
                              padding: const EdgeInsets.only(top: 10),
                              icon: const Icon(Icons.edit),
                              iconSize: 24,
                              color: const Color(0xfff7f7f7)),
                          IconButton(
                              onPressed: () => Navigator.pushNamed(
                                      context, "/profil_settings", arguments: {
                                    "data": _listData,
                                    "user": _user
                                  }),
                              splashRadius: 1,
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              icon: const Icon(Icons.settings),
                              iconSize: 24,
                              color: const Color(0xfff7f7f7))
                        ],
                      ),
                      const Text(
                        "Profil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 75,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xfff7f7f7),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: .5,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(70),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage('images/image1.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xfff7f7f7),
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Color(0xfff7f7f7),
                                    width: 1.0,
                                    style: BorderStyle.solid))),
                        child: _showData == false
                            ? Container(
                                color: const Color(0xfff7f7f7),
                                width: double.infinity,
                                height: 400,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                    color: Colors.brown[300]))
                            : Column(
                                children: [
                                  const SizedBox(height: 20),
                                  _customCard(
                                      Icons.person_outline, _user?.displayName),
                                  _customCard(Icons.wallet,
                                      _listData!['saldo'].toString()),
                                  _customCard(
                                      Icons.data_array, _listData!['gender']),
                                  _customCard(Icons.date_range,
                                      _listData!['tanggal_lahir']),
                                  _customCard(
                                      Icons.mail_outlined, _user?.email),
                                  _customCard(Icons.phone_outlined,
                                      _listData!['telepon']),
                                  _customCard(
                                      Icons.location_pin, _listData!['alamat']),
                                  const SizedBox(height: 20),
                                ],
                              ),
                      ),
                    ],
                  )),
            ),
          ),
          navbarCustomContainer(context, 3)
        ],
      ),
    );
  }
}
