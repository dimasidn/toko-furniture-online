import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../conf/firestore.dart';

class PencarianScreen extends StatefulWidget {
  const PencarianScreen({Key? key}) : super(key: key);

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  final FocusNode _focus = FocusNode();
  List? _data, _datasearch;
  Map<String, dynamic>? _tokoData, _productData;
  bool isSearch = false, _showData = false;
  late ScrollController _scrollPoint;
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);

  Future<void> _readJson() async {
    final String respone = await rootBundle.loadString('assets/dummy.json');
    final data = await jsonDecode(respone);
    _data = data;
  }

  Future<void> _cariBarang(String string) async {
    if (_datasearch != null) {
      _datasearch!.clear();
    }
    _datasearch = [];
    for (var i = 0; i < _data!.length; i++) {
      String nama = _data![i]['nama'];
      String ktgr = _data![i]['kategori'];
      if (nama.toUpperCase().contains(string.toUpperCase()) == true ||
          ktgr.toUpperCase().contains(string.toUpperCase()) == true) {
        _datasearch!.add(_data![i]);
      }
    }
  }

  Future<void> _cariProduk(String string) async {
    if (_datasearch != null) _datasearch!.clear();
    _datasearch = [];
    for (var i = 0; i < _productData!['data']!.length; i++) {
      String nama = _productData!['data']![i]['nama'];
      String ktgr = _productData!['data']![i]['kategori'];
      if (nama.toUpperCase().contains(string.toUpperCase()) == true ||
          ktgr.toUpperCase().contains(string.toUpperCase()) == true) {
        _datasearch!.add(_productData!['data']![i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollPoint = ScrollController();
    _focus.addListener(() => setState(() {}));
    Future.delayed(Duration.zero, () async {
      _tokoData = await Firestore.getData('database', 'toko');
      _productData = await Firestore.getData('database', 'products');
      setState(() {
        _showData = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
    //if (_data != null) _data!.clear();
    if (_tokoData != null) _tokoData!.clear();
    if (_productData != null) _productData!.clear();
    _scrollPoint.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Icon(color: Colors.brown[200], Icons.arrow_back),
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(14),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Colors.brown.shade200,
                          width: 1.2,
                          style: BorderStyle.solid)),
                  child: TextField(
                    focusNode: _focus,
                    cursorColor: Colors.pinkAccent,
                    maxLines: 1,
                    cursorWidth: 1.5,
                    textInputAction: TextInputAction.search,
                    enableSuggestions: false,
                    style: const TextStyle(color: Colors.pinkAccent),
                    onSubmitted: (text) async {
                      await _cariProduk(text);
                      setState(() {
                        isSearch = true;
                        if (_scrollPoint.hasClients) {
                          _scrollPoint.animateTo(
                              _scrollPoint.position.minScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        }
                      });
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: _focus.hasFocus
                            ? null
                            : 'Cari furniture impian anda disini',
                        hintStyle: const TextStyle(fontSize: 14),
                        isCollapsed: false,
                        isDense: true,
                        hoverColor: Colors.white,
                        border: InputBorder.none),
                    enabled: _showData == true ? true : false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(color: Colors.brown[200], Icons.shopping_cart),
              )
            ],
          ),
          Divider(thickness: 0.6, height: 0.6, color: Colors.brown[200]),
          Expanded(
              child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: isSearch == true
                      ? GridView.builder(
                          shrinkWrap: false,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(14),
                          controller: _scrollPoint,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 18,
                                  mainAxisExtent: 332),
                          itemCount:
                              _datasearch != null ? _datasearch!.length : 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, "/produk",
                                    arguments: {"produk": _datasearch![index]}),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                        child: Container(
                                            height: 180,
                                            color: Colors.grey[200],
                                            child: FadeInImage(
                                                image: NetworkImage(
                                                    _datasearch![index]
                                                        ["gambar"][0]),
                                                fit: BoxFit.cover,
                                                placeholder: const AssetImage(
                                                    "assets/loading_animate_eclipse.gif"),
                                                placeholderFit: BoxFit.cover,
                                                imageErrorBuilder: (context,
                                                    exception, stackTrace) {
                                                  return const Text(
                                                      "Cannot load image");
                                                }))),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(_datasearch![index]['nama'],
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(
                                                idrFormat.format(
                                                    _datasearch![index]
                                                        ['harga']),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                "Rating : ${_datasearch![index]['rating']}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.pinkAccent)),
                                            Text(_tokoData!['data'][
                                                _datasearch![index]['id_toko'] -
                                                    1]['nama']),
                                            Text(_tokoData!['data'][
                                                _datasearch![index]['id_toko'] -
                                                    1]['alamat'])
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Image.asset(
                            _showData == true
                                ? 'assets/logosearch.png'
                                : 'assets/loading_animate_eclipse.gif',
                            width: screen.width / 2.5,
                            fit: BoxFit.fitWidth,
                          ))))
        ],
      ),
    );
  }
}
