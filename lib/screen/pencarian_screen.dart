import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PencarianScreen extends StatefulWidget {
  const PencarianScreen({Key? key}) : super(key: key);

  @override
  State<PencarianScreen> createState() => _PencarianScreenState();
}

class _PencarianScreenState extends State<PencarianScreen> {
  final FocusNode _focus = FocusNode();
  List? _data, _datasearch;
  bool isSearch = false;
  late ScrollController _scrollPoint;
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);

  Future<void> readJson() async {
    final String respone = await rootBundle.loadString('assets/dummy.json');
    final data = await jsonDecode(respone);
    _data = data;
  }

  Future<void> cariBarang(String string) async {
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

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
    _scrollPoint = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(() {});
    _focus.dispose();
    _data!.clear();
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
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Icon(color: Colors.brown[200], Icons.arrow_back),
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
                    onSubmitted: (value) async {
                      if (_data == null) {
                        await readJson();
                      }
                      setState(() {
                        cariBarang(value);
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
                    autofocus: true,
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
                  child: isSearch
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
                                  mainAxisExtent: 320),
                          itemCount:
                              _datasearch != null ? _datasearch!.length : 0,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(15)),
                                      child: Container(
                                          height: 180,
                                          color: Colors.pinkAccent,
                                          child: Image.network(
                                              _datasearch![index]["gambar"][0],
                                              fit: BoxFit.fitHeight))),
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
                                                  fontWeight: FontWeight.w500)),
                                          Text(
                                              idrFormat.format(
                                                  _datasearch![index]['harga']),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Rating : ${_datasearch![index]['rating']}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pinkAccent)),
                                          Text(
                                              "ID_Toko : ${(_datasearch![index]['id_toko']).toString()}"),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                      : Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/logosearch.png',
                            width: screen.width / 2.5,
                            fit: BoxFit.fitWidth,
                          ))))
        ],
      ),
    );
  }
}
