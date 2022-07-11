import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({Key? key}) : super(key: key);

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  int countProduk = 8;
  int? _total;
  List? _jsonData, _produk;
  List<int>? _jumlahperproduk;
  bool _showData = false, _showJumlah = false;
  Random inirandom = Random();

  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);

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
      _jumlahperproduk = [
        1,
        1,
        inirandom.nextInt(5) + 1,
        inirandom.nextInt(4) + 1,
        inirandom.nextInt(3) + 1,
        inirandom.nextInt(5) + 1,
        inirandom.nextInt(4) + 1,
        inirandom.nextInt(3) + 1,
      ];
      setState(() {
        _jsonData!.shuffle();
        _jsonData!.shuffle();
        _jsonData!.shuffle();
        _jumlahperproduk!.shuffle();
        _showData = true;
      });
      int jumlahHarga = 0;
      for (var i = 0; i < countProduk; i++) {
        int count = await (_jsonData![i]['harga'] * _jumlahperproduk![i]);
        jumlahHarga += count;
      }
      setState(() {
        _total = jumlahHarga;
        _showJumlah = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_jsonData != null) _jsonData!.clear();
    if (_jumlahperproduk != null) _jumlahperproduk!.clear();
    if (_produk != null) _produk!.clear();
    if (_total != null) _total = null;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top + 50,
            width: screen.width,
            color: Colors.brown[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white)),
                    ),
                    const Flexible(
                        child: Center(
                      child: Text(
                        'Keranjang Belanja',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )),
                    GestureDetector(
                      onTap: () => _snackBarCustom(
                          message: 'Fitur dalam pengembangan :)',
                          color: Colors.orange),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 40,
                          height: 40,
                          child: const Icon(Icons.share, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            child: _showData == false
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 14),
                    shrinkWrap: false,
                    itemCount: countProduk,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 2,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.all(1),
                                height: 80,
                                width: 80,
                                child: FadeInImage(
                                    image: NetworkImage(
                                        _jsonData![index]['gambar'][0]),
                                    fit: BoxFit.fitHeight,
                                    placeholder: const AssetImage(
                                        "assets/loading_animate_eclipse.gif"),
                                    placeholderFit: BoxFit.fitWidth,
                                    imageErrorBuilder:
                                        (context, exception, stackTrace) {
                                      return const Text("Cannot load image");
                                    }),
                              ),
                              Flexible(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _jsonData![index]['nama'],
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'X ${_jumlahperproduk![index].toString()}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        idrFormat.format((_jsonData![index]
                                                ['harga'] *
                                            _jumlahperproduk![index])),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
          ),
          SizedBox(
            width: screen.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                    height: 1,
                    color: Colors.brown[200],
                    indent: 12,
                    endIndent: 12),
                Container(
                    color: Colors.grey[200],
                    height: 48,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        _showJumlah == false
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
                                        borderRadius: BorderRadius.circular(5)),
                                    width: screen.width * .29,
                                    height: 12))
                            : Text(idrFormat.format(_total),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    )),
                GestureDetector(
                  onTap: () async {
                    _produk = [];
                    for (var i = 0; i < countProduk; i++) {
                      Map<String, dynamic>? produkForList = {
                        "nama": _jsonData![i]['nama'],
                        "harga": _jsonData![i]['harga'],
                        "jumlah": _jumlahperproduk![i],
                        "gambar": _jsonData![i]['gambar'][0]
                      };
                      _produk!.add(produkForList);
                    }
                    Navigator.pushNamed(context, "/checkout",
                        arguments: {"produk": _produk, "total": _total});
                  },
                  child: Container(
                    color: Colors.brown[300],
                    height: 50,
                    child: const Center(
                        child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
