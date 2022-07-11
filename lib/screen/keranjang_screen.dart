import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({Key? key}) : super(key: key);

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  int countProduk = 9;
  int subTotal(int count) {
    var counting = 0;
    for (var i = 0; i < count; i++) {
      counting += count * 1000000;
    }
    return counting + (990000 * count);
  }

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
                          child: Icon(Icons.arrow_back, color: Colors.white)),
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
                          child: Icon(Icons.share, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
                shrinkWrap: false,
                itemCount: countProduk,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 80,
                            width: 80,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.pinkAccent,
                              size: 32,
                            ),
                          ),
                          Flexible(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'ProdukProdukProduk_ProdukProduk_${index + 1}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'X ${index + 1}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Rp ${index + 1}.990.000',
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
                        Text('Subtotal',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(idrFormat.format(subTotal(countProduk)),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    )),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/checkout"),
                  child: Container(
                    color: Colors.brown[300],
                    height: 50,
                    child: Center(
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
