import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../conf/navigatebar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);
  List? _jsonData, _jsonToko;
  bool _showData = false;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom(
      {required String message, required Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final String respone1 = await rootBundle.loadString('assets/dummy.json');
      final data1 = await jsonDecode(respone1);
      _jsonData = data1;
      final String respone2 =
          await rootBundle.loadString('assets/dummy_toko.json');
      final data2 = await jsonDecode(respone2);
      _jsonToko = data2;
      setState(() {
        _jsonData!.shuffle();
        _jsonData!.shuffle();
        _jsonData!.shuffle();
        _showData = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_jsonData != null) _jsonData!.clear();
    if (_jsonToko != null) _jsonToko!.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.brown[200]),
          height: MediaQuery.of(context).viewPadding.top + 50,
          width: screen.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              Row(
                children: [
                  const SizedBox(width: 40),
                  const Flexible(
                    child: Center(
                      child: Text(
                        'Keinginan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _snackBarCustom(
                        message: 'Fitur dalam pengembangan :)',
                        color: Colors.orange),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: _showData == false
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(14),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 18,
                      mainAxisExtent: 300),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/produk",
                            arguments: {"produk": _jsonData![index]}),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Container(
                                    height: 180,
                                    color: Colors.pinkAccent,
                                    child: FadeInImage(
                                        image: NetworkImage(
                                            _jsonData![index]['gambar'][0]),
                                        fit: BoxFit.fitHeight,
                                        placeholder: const AssetImage(
                                            "assets/loading_animate_standart.gif"),
                                        placeholderFit: BoxFit.fitWidth,
                                        imageErrorBuilder:
                                            (context, exception, stackTrace) {
                                          return const Text(
                                              "Cannot load image");
                                        }))),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _jsonData![index]['nama'],
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(idrFormat
                                        .format(_jsonData![index]['harga'])),
                                    Text(_jsonToko![
                                            _jsonData![index]['id_toko'] - 1]
                                        ['alamat']),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
        ),
        navbarCustomContainer(context, 1)
      ]),
    );
  }
}
