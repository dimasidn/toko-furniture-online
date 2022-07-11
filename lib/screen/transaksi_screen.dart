import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../conf/navigatebar.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({Key? key}) : super(key: key);

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);
  List? data, data1;
  late PageController _pageController;
  int activePage = 0;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom(
      {required String message, required Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ));
  }

  void indicatorTap(toPage) {
    setState(() {
      _pageController.jumpToPage(toPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    data = [
      ['Meja makan limited edition', 8454211, 5],
      ['Kursi makan kayu jati', 5784448, 3]
    ];
    data1 = [
      ['Meja makan limited edition', 8454211, 5],
      ['Kursi makan kayu jati', 5784448, 3],
      ['Lemari pakaian Ukir asli jogja', 4544444, 0],
      ['Rak sepatu asli original', 2254587, 1],
      ['ProdukProduk_produk xyz zz', 2651646, 8],
      ['ProdukProduk_produk klm zz', 2651646, 9],
      ['ProdukProduk_produk jkl zz', 2651646, 10],
      ['ProdukProduk_produk opq zz', 2651646, 11],
    ];
  }

  @override
  void dispose() {
    data!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
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
                          'Transaksi Belanja',
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
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: screen.width,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    if (activePage == 1) {
                      _pageController.jumpToPage(0);
                    }
                  }),
                  child: Container(
                    width: screen.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: activePage == 0 ? null : Colors.grey[300],
                        border: Border(
                            right: BorderSide(
                                width: 1, color: Colors.brown.shade400),
                            left: BorderSide(
                                width: 1, color: Colors.brown.shade400))),
                    child: Text('Proses',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: activePage == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: activePage == 0
                                ? Colors.pinkAccent
                                : Colors.brown[400])),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    if (activePage == 0) {
                      _pageController.jumpToPage(1);
                    }
                  }),
                  child: Container(
                    width: screen.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: activePage == 0 ? Colors.grey[300] : null,
                        border: Border(
                            right: BorderSide(
                                width: 1, color: Colors.brown.shade400),
                            left: BorderSide(
                                width: 1, color: Colors.brown.shade400))),
                    child: Text('Riwayat',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: activePage == 0
                                ? FontWeight.normal
                                : FontWeight.bold,
                            color: activePage == 0
                                ? Colors.brown[400]
                                : Colors.pinkAccent)),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              children: [
                ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  shrinkWrap: false,
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1.5,
                      child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 80, width: 80, color: Colors.blue),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data![index][0],
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(idrFormat.format(data![index][1])),
                                        Flexible(child: Container()),
                                        Text(data![index][2] == 0
                                            ? ""
                                            : "+${data![index][2].toString()}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(child: Container()),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(
                                            Icons.chat,
                                            color: Colors.brown[200],
                                          ),
                                        ),
                                        ConstrainedBox(
                                            constraints:
                                                const BoxConstraints.tightFor(
                                                    width: 80, height: 30),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.pinkAccent),
                                                onPressed: () {},
                                                child: const Text("Lacak")))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
                ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
                  shrinkWrap: false,
                  itemCount: data1!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1.5,
                      child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 80, width: 80, color: Colors.blue),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data1![index][0],
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(
                                            idrFormat.format(data1![index][1])),
                                        Flexible(child: Container()),
                                        Text(data1![index][2] == 0
                                            ? ""
                                            : "+${data1![index][2].toString()}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(child: Container()),
                                        ConstrainedBox(
                                            constraints:
                                                const BoxConstraints.tightFor(
                                                    width: 110, height: 30),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.brown[200]),
                                                onPressed: () {},
                                                child:
                                                    const Text("Lihat detail")))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                )
              ],
            ),
          ),
          navbarCustomContainer(context, 2)
        ],
      ),
    );
  }
}
