import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  Widget menutes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.bed, size: 36, color: Colors.pinkAccent),
        Icon(Icons.chair, size: 36, color: Colors.brown[200])
      ],
    );
  }

  Widget menutes1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.table_restaurant, size: 36, color: Colors.brown[200]),
        Icon(Icons.deck_outlined, size: 36, color: Colors.pinkAccent)
      ],
    );
  }

  Widget flashSaleProduct(String namaProduk, String hargaOld, String hargaNew) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Container(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                  color: Colors.grey[300]),
              child: Icon(Icons.image_not_supported_outlined,
                  size: 40, color: Colors.pinkAccent),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(namaProduk, style: TextStyle(fontSize: 11)),
                  Text('Rp $hargaNew',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text('Rp $hargaOld',
                      style: TextStyle(
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

  Widget RecommendProduct(String namaProduk, String harga, String kirimdari) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Container(
        height: 180,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 116,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  color: Colors.grey[300]),
              child: Icon(Icons.image_not_supported_outlined,
                  size: 40, color: Colors.pinkAccent),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(namaProduk, style: TextStyle(fontSize: 11)),
                  Text('Rp $harga',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          size: 10, color: Colors.pinkAccent),
                      Text(" $kirimdari",
                          style: TextStyle(
                              fontSize: 10, color: Colors.pinkAccent)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizescreen = MediaQuery.of(context).size;
    Widget menuIcon(IconData? icon, Color customColor) {
      return SizedBox(
        width: sizescreen.width / 4,
        height: double.infinity,
        child: Center(child: Icon(icon, color: customColor)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 116 + MediaQuery.of(context).viewPadding.top,
                    child: Stack(
                      children: [
                        Container(
                            color: Colors.brown[200],
                            height: 110,
                            width: sizescreen.width),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewPadding.top + 14,
                                left: 14,
                                right: 14),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: sizescreen.width * (6 / 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1.2,
                                              style: BorderStyle.solid)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Icon(
                                              Icons.search,
                                              size: 20,
                                              color: Colors.pinkAccent,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Icon(
                                        color: Colors.white,
                                        Icons.shopping_cart),
                                    Icon(
                                        color: Colors.white,
                                        Icons.mail_outline),
                                    Icon(
                                        color: Colors.white,
                                        Icons.notifications)
                                  ],
                                ),
                                Card(
                                    elevation: 1.5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9)),
                                    margin: EdgeInsets.symmetric(vertical: 14),
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: 44,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text('Saldo',
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text('Rp 25.840.000',
                                                    style:
                                                        TextStyle(fontSize: 12))
                                              ],
                                            ),
                                            Icon(
                                              Icons.discount,
                                              color: Colors.pinkAccent,
                                              size: 24,
                                              semanticLabel: 'VOUCHER',
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 110,
                      width: sizescreen.width,
                      padding: EdgeInsets.only(top: 4, bottom: 20),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            menutes(),
                            SizedBox(width: 20),
                            menutes1(),
                            SizedBox(width: 20),
                            menutes(),
                            SizedBox(width: 20),
                            menutes1(),
                            SizedBox(width: 20),
                            menutes(),
                            SizedBox(width: 20),
                            menutes1(),
                            SizedBox(width: 20),
                            menutes(),
                            SizedBox(width: 20),
                            menutes1(),
                            SizedBox(width: 20),
                            menutes(),
                            SizedBox(width: 20),
                          ],
                        ),
                      )),
                  Container(
                    color: Colors.grey[100],
                    height: 278,
                    width: sizescreen.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(14, 12, 0, 5),
                          child: Text('FlashSale',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              flashSaleProduct('MEJAMEJAMEJA MEJAMEJA',
                                  '5.225.000', '4.444.000'),
                              SizedBox(width: 8),
                              flashSaleProduct('KURSIKURSIKU RSIKURSI',
                                  '2.740.000', '1.820.000'),
                              SizedBox(width: 8),
                              flashSaleProduct('SOFASOFASOFA SOFASOFA',
                                  '6.810.000', '5.810.000'),
                              SizedBox(width: 8),
                              flashSaleProduct('LEMARILEMARI LEMARILE',
                                  '9.125.000', '8.250.000'),
                              SizedBox(width: 8),
                              flashSaleProduct('POTBUNGA POTBUNGA POT',
                                  '940.000', '800.000'),
                              SizedBox(width: 8),
                              flashSaleProduct('KARPET KULIT HARYMAU',
                                  '99.880.000', '89.990.000'),
                              SizedBox(width: 10)
                            ],
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
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(14, 12, 0, 5),
                          child: Text('Rekomendasi',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              RecommendProduct('LEMARILEMARI LEMARILE',
                                  '9.125.000', 'Jakarta Utara'),
                              SizedBox(width: 8),
                              RecommendProduct('POTBUNGA POTBUNGA POT',
                                  '940.000', 'Semarang'),
                              SizedBox(width: 8),
                              RecommendProduct('KARPET KULIT HARYMAU',
                                  '99.880.000', 'Surabaya'),
                              SizedBox(width: 8),
                              RecommendProduct('MEJAMEJAMEJA MEJAMEJA',
                                  '5.225.000', 'Surakarta'),
                              SizedBox(width: 8),
                              RecommendProduct('KURSIKURSIKU RSIKURSI',
                                  '2.740.000', 'Palembang'),
                              SizedBox(width: 8),
                              RecommendProduct('SOFASOFASOFA SOFASOFA',
                                  '6.810.000', 'Bandung'),
                              SizedBox(width: 10)
                            ],
                          ),
                        )
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
                  SizedBox(height: 51)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  menuIcon(Icons.home, Colors.pinkAccent),
                  menuIcon(Icons.favorite_border, Colors.brown.shade300),
                  menuIcon(Icons.list_alt_outlined, Colors.brown.shade300),
                  menuIcon(Icons.account_box, Colors.brown.shade300)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
