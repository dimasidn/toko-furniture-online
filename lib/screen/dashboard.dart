import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? data;
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);
  List<IconData?>? _navbarIcons, _menuAppIcons;

  @override
  void initState() {
    super.initState();
    data = [
      ['MEJAMEJAMEJA MEJAMEJA sfsf sf sfsffs', 5225000, 4444000],
      ['KURSIKURSIKU RSIKURSI ss s ffs fsf sf', 2740000, 1820000],
      ['SOFASOFASOFA SOFASOFA sf sf sf fss s', 6810000, 5810000],
      ['LEMARILEMARI LEMARILE sff sf sfsf', 9125000, 8250000],
      ['POTBUNGA POTBUNGA POT sf sfsf fssf s', 940000, 800000],
      ['KARPET KULIT HARYMAU sf ssff  sfff', 99880000, 89990000]
    ];
    _navbarIcons = [
      Icons.home,
      Icons.favorite_border,
      Icons.list_alt_outlined,
      Icons.account_box_rounded
    ];
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
  }

  @override
  void dispose() {
    data = [];
    _menuAppIcons = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizescreen = MediaQuery.of(context).size;
    List<Widget> navbar(barLength, currentIndex) {
      return List<Widget>.generate(barLength, (index) {
        return SizedBox(
            width: sizescreen.width / 4,
            height: double.infinity,
            child: Center(
                child: Icon(_navbarIcons![index],
                    color: currentIndex == index
                        ? Colors.pinkAccent
                        : Colors.brown[300])));
      });
    }

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
                        child: Container(
                          height: 30,
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
                              Text('Cari furniture impian anda disini',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.black45))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 14),
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(color: Colors.white, Icons.shopping_cart),
                            Icon(color: Colors.white, Icons.mail_outline),
                            Icon(color: Colors.white, Icons.notifications),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text('Saldo',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold)),
                                    Text('Rp 25.840.000',
                                        style: TextStyle(fontSize: 12))
                                  ],
                                ),
                                const Icon(
                                  Icons.discount,
                                  color: Colors.pinkAccent,
                                  size: 24,
                                  semanticLabel: 'VOUCHER',
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: sizescreen.width,
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
                  height: 340,
                  width: sizescreen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(14, 12, 0, 8),
                        child: Text('Flash Sale',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(14),
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.only(right: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: SizedBox(
                                width: 150,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                        child: Container(
                                            height: 180,
                                            color: Colors.pinkAccent,
                                            child: Center(
                                                child: Text(
                                                    "Gambar ke-${index + 1}")))),
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
                                            Text(data?[index][0],
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(
                                                idrFormat
                                                    .format(data?[index][2]),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                idrFormat
                                                    .format(data?[index][1]),
                                                style: const TextStyle(
                                                    color: Colors.pinkAccent,
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .lineThrough)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
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
                  color: Colors.grey[100],
                  height: 240,
                  width: sizescreen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 12, 0, 5),
                        child: Text('Rekomendasi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  height: 236,
                  width: sizescreen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 0, 5),
                        child: Text('Submenu 3',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  height: 236,
                  width: sizescreen.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 14, 0, 5),
                        child: Text('Submenu 4',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: sizescreen.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: Colors.grey.shade500,
                        width: 1,
                        style: BorderStyle.solid))),
            child: Row(
              children: navbar(_navbarIcons!.length, 0),
            ),
          )
        ],
      ),
    );
  }
}
