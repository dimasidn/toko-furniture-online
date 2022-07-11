import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../conf/firestore.dart';
import '../conf/navigatebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;
  Map<String, dynamic>? _userData, _tokoData, _productData;
  bool _showData = false;
  List<dynamic>? _produkCustomDashboard;
  List<IconData?>? _menuAppIcons;
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);

  int _randomDiscountSimulation(int harga) {
    var newHarga = harga - (harga * ((Random().nextInt(51) + 5) / 100));
    return int.parse(newHarga.toStringAsFixed(0));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom(
      {required String message, required Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ));
  }

  Widget _customCardProduct(Map<String, dynamic>? data) {
    return SizedBox(
      height: 320,
      child: Card(
        elevation: 3,
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/produk",
              arguments: {"produk": data}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                      color: Colors.white,
                      height: 200,
                      width: double.infinity,
                      child: FadeInImage(
                          image: NetworkImage(data!['gambar'][0]),
                          fit: BoxFit.fitHeight,
                          placeholder: const AssetImage(
                              "assets/loading_animate_eclipse.gif"),
                          placeholderFit: BoxFit.fitHeight,
                          imageErrorBuilder: (context, exception, stackTrace) {
                            return const Text("Cannot load image");
                          }))),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data['nama'],
                          style: const TextStyle(fontSize: 18),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                      Text(idrFormat.format(data['harga']),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent)),
                      Text(_tokoData!['data'][data['id_toko'] - 1]['nama']),
                      Row(
                        children: [
                          Text("Rating : ${data['rating']}",
                              style: const TextStyle(color: Colors.pinkAccent)),
                          Text(
                              " | ${_tokoData!['data'][data['id_toko'] - 1]['alamat']}"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;

    _menuAppIcons = [
      Icons.bed,
      Icons.chair,
      Icons.table_bar,
      Icons.deck_outlined,
      Icons.table_restaurant,
      Icons.chair_alt,
      Icons.window,
      Icons.door_sliding,
      Icons.door_front_door_outlined,
      Icons.bathtub_outlined,
      Icons.bedroom_child,
      Icons.king_bed_rounded,
      Icons.kitchen
    ];
    Future.delayed(Duration.zero, () async {
      _userData = await Firestore.getData('users', (_user?.uid).toString());
      _tokoData = await Firestore.getData('database', 'toko');
      _productData = await Firestore.getData('database', 'products');
      setState(() {
        _produkCustomDashboard = _productData!['data'];
        _produkCustomDashboard!.shuffle();
        _produkCustomDashboard!.shuffle();
        _produkCustomDashboard!.shuffle();
        _showData = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _menuAppIcons = [];
    _user = null;
    if (_userData != null) _userData!.clear();
    if (_tokoData != null) _tokoData!.clear();
    if (_productData != null) _productData!.clear();
    if (_produkCustomDashboard != null) _produkCustomDashboard!.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: ListView(
              primary: true,
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, bottom: 14, top: 14),
                  color: Colors.brown[200],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "/pencarian"),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.2,
                                    style: BorderStyle.solid)),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(Icons.search,
                                      size: 20, color: Colors.pinkAccent),
                                ),
                                Flexible(
                                  child: Text(
                                      'Cari furniture impian anda disini',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.black45)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 14),
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/keranjang'),
                                child: Icon(
                                    color: Color(0xFFFFFFFF),
                                    Icons.shopping_cart)),
                            GestureDetector(
                                onTap: () => _snackBarCustom(
                                    message: 'Fitur dalam pengembangan :)',
                                    color: Colors.orange),
                                child: Icon(
                                    color: Color(0xFFFFFFFF),
                                    Icons.mail_outline)),
                            GestureDetector(
                                onTap: () => _snackBarCustom(
                                    message: 'Fitur dalam pengembangan :)',
                                    color: Colors.orange),
                                child: Icon(
                                    color: Color(0xFFFFFFFF),
                                    Icons.notifications)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(height: 26, color: Colors.brown[200]),
                        Container(height: 26, color: Colors.white),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          color: Colors.white,
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Saldo',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold)),
                                    _showData == false
                                        ? Flexible(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.grey.shade300,
                                                        Colors.grey.shade200
                                                      ],
                                                      stops: const [
                                                        0.1,
                                                        0.9,
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                width: screen.width * .29,
                                                height: 12))
                                        : Text(
                                            idrFormat
                                                .format(_userData!['saldo']),
                                            style:
                                                const TextStyle(fontSize: 12))
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => _snackBarCustom(
                                      message: 'Fitur dalam pengembangan :)',
                                      color: Colors.orange),
                                  child: const Icon(
                                    Icons.discount,
                                    color: Colors.pinkAccent,
                                    size: 24,
                                    semanticLabel: 'VOUCHER',
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: screen.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.brown.shade200,
                              width: 0.6,
                              style: BorderStyle.solid))),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      scrollDirection: Axis.horizontal,
                      itemCount: _menuAppIcons!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              right:
                                  _menuAppIcons!.length != index + 1 ? 20 : 0),
                          child: Icon(_menuAppIcons![index],
                              size: 36,
                              color: index % 2 == 0
                                  ? Colors.pinkAccent
                                  : Colors.brown[300]),
                        );
                      }),
                ),
                Container(
                  color: Colors.grey[100],
                  height: 360,
                  width: screen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(14, 12, 0, 8),
                        child: Text('Flash Sale',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      _showData == false
                          ? Container(
                              height: 300,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: Colors.pinkAccent))
                          : Flexible(
                              child: ListView.builder(
                                primary: false,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(14),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 3,
                                    margin: const EdgeInsets.only(right: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () => _snackBarCustom(
                                          message:
                                              'Fitur Harga Flashsale dalam pengembangan',
                                          color: Colors.orange),
                                      //Navigator.pushNamed(context, "/produk"),
                                      child: SizedBox(
                                        width: 150,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .vertical(
                                                    top: Radius.circular(15)),
                                                child: Container(
                                                    height: 180,
                                                    width: 150,
                                                    color: Colors.white,
                                                    child: FadeInImage(
                                                        image: NetworkImage(
                                                            _produkCustomDashboard![
                                                                    index]
                                                                ['gambar'][0]),
                                                        fit: BoxFit.fitHeight,
                                                        placeholder:
                                                            const AssetImage(
                                                                "assets/loading_animate_eclipse.gif"),
                                                        placeholderFit:
                                                            BoxFit.fitWidth,
                                                        imageErrorBuilder:
                                                            (context, exception,
                                                                stackTrace) {
                                                          return const Text(
                                                              "Cannot load image");
                                                        }))),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        _produkCustomDashboard![
                                                            index]['nama'],
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                        idrFormat.format(
                                                            _randomDiscountSimulation(
                                                                _produkCustomDashboard![
                                                                        index]
                                                                    ['harga'])),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        idrFormat.format(
                                                            _produkCustomDashboard![
                                                                    index]
                                                                ['harga']),
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .pinkAccent,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                    ],
                  ),
                ),
                Container(
                  color: Colors.brown[100],
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  width: screen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Rekomendasi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      _showData == true
                          ? _customCardProduct(_produkCustomDashboard![10])
                          : Container(
                              height: 320,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: Colors.pinkAccent)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Terlaris',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      _showData == true
                          ? _customCardProduct(_produkCustomDashboard![20])
                          : Container(
                              height: 320,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: Colors.pinkAccent)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Mungkin kamu juga suka',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      _showData == true
                          ? _customCardProduct(_produkCustomDashboard![30])
                          : Container(
                              height: 320,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: Colors.pinkAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          navbarCustomContainer(context, 0)
        ],
      ),
    );
  }
}
