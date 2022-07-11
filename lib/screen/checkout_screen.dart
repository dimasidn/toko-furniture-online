import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _kurir, _metpem;
  final List _listKurir = ["JNE Cargo", "J&T Cargo", "SiCepat Cargo"];
  String _listHargaKurir(String? kurir) {
    String aaa;
    if (kurir == "JNE Cargo") {
      aaa = "Rp 240.000";
    } else if (kurir == "J&T Cargo") {
      aaa = "Rp 250.000";
    } else if (kurir == "SiCepat Cargo") {
      aaa = "Rp 245.000";
    } else {
      aaa = "";
    }
    return aaa;
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

  Widget _containerCustom(double? height, Widget? child) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: Colors.brown.shade200,
                width: 3,
                style: BorderStyle.solid)),
        child: child);
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
                        'Checkout',
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
            child: ListView(
              padding: EdgeInsets.all(14),
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              children: [
                _containerCustom(
                    120,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Penerima : BUNG TOMO',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Fakultas Ilmu Komputer Universitas Duta Bangsa, Jl. Bhayangkara No.55, Tipes, Kec. Serengan, Kota Surakarta, Jawa Tengah 57154',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )),
                _containerCustom(
                    60,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          hint: Text("Pilih jasa kirim"),
                          isDense: true,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          value: _kurir,
                          icon: Icon(Icons.arrow_drop_down_circle_outlined),
                          underline: Container(),
                          items: _listKurir.map((value) {
                            return DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                                value: value);
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _kurir = value.toString();
                            });
                          },
                        ),
                        Text(_listHargaKurir(_kurir),
                            style: TextStyle(fontSize: 20, color: Colors.black))
                      ],
                    )),
                ListView.builder(
                  primary: false,
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, style: BorderStyle.solid)),
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            color: Colors.grey,
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.pinkAccent,
                              size: 24,
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ProdukProdukProduk_ProdukProduk_${index + 1}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${index + 1} X Rp ${index + 1}.990.000',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                _containerCustom(
                    60,
                    DropdownButton(
                      isExpanded: true,
                      hint: Text("Pilih Metode Pembayaran"),
                      isDense: true,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      value: _metpem,
                      icon: Icon(Icons.arrow_drop_down_circle_outlined),
                      underline: Container(),
                      items:
                          ["BRI", "BNI", "BCA", "Mandiri", "BTN"].map((value) {
                        return DropdownMenuItem(
                            child: Text(value,
                                style: TextStyle(color: Colors.black)),
                            value: value);
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _metpem = value.toString();
                        });
                      },
                    )),
                _containerCustom(
                    60,
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Masukkan Kode Voucher",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal)),
                      cursorColor: Colors.brown[200],
                      style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
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
                    //height: 48,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Rp 99.999.000',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Diskon',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Rp 599.000',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Jasa Kirim',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Rp 250.000',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Rp 99.650.000',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, "/transaksi"),
                  child: Container(
                    color: Colors.brown[300],
                    height: 50,
                    child: Center(
                        child: Text(
                      'BAYAR',
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
