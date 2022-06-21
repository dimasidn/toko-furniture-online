import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData?>? _navbarIcons, _menuAppIcons;

  List<Widget> menuApp(menuLength, currentIndex) {
    return List<Widget>.generate(menuLength, (index) {
      return SizedBox(
          width: 60,
          height: double.infinity,
          child: Center(
              child: Icon(_menuAppIcons![index],
                  size: 36,
                  color:
                      index % 2 == 0 ? Colors.pinkAccent : Colors.brown[300])));
    });
  }

  Widget flashSaleProduct(String namaProduk, String hargaOld, String hargaNew) {
    return Card(
      margin: const EdgeInsets.only(right: 14, bottom: 4),
      color: Colors.white,
      elevation: 4,
      child: SizedBox(
        height: 220,
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(4)),
                  color: Colors.grey[300]),
              child: const Icon(Icons.image_not_supported_outlined,
                  size: 40, color: Colors.pinkAccent),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(namaProduk, style: const TextStyle(fontSize: 11)),
                  Text('Rp $hargaNew',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text('Rp $hargaOld',
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.pinkAccent,
                          decoration: TextDecoration.lineThrough)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
                  height: 60,
                  width: sizescreen.width,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 14, left: 14, right: 14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.brown.shade200,
                              width: 0.6,
                              style: BorderStyle.solid))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: menuApp(_menuAppIcons!.length, 0),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  height: 270,
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              flashSaleProduct('MEJAMEJAMEJA MEJAMEJA',
                                  '5.225.000', '4.444.000'),
                              flashSaleProduct('KURSIKURSIKU RSIKURSI',
                                  '2.740.000', '1.820.000'),
                              flashSaleProduct('SOFASOFASOFA SOFASOFA',
                                  '6.810.000', '5.810.000'),
                              flashSaleProduct('LEMARILEMARI LEMARILE',
                                  '9.125.000', '8.250.000'),
                              flashSaleProduct('POTBUNGA POTBUNGA POT',
                                  '940.000', '800.000'),
                              flashSaleProduct('KARPET KULIT HARYMAU',
                                  '99.880.000', '89.990.000'),
                            ],
                          ),
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
