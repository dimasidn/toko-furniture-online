import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _kurir, _metpem;
  bool _isKurirSelected = false;
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);

  final Map<String, int> _listKurir = {
    "JNE Cargo": 240000,
    "J&T Cargo": 250000,
    "SiCepat Cargo": 245000
  };

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom(
      {required String message, required Color? color}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
    ));
  }

  Widget _containerCustom(double? height, Widget? child) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_kurir != null) _kurir = null;
    if (_metpem != null) _metpem = null;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    List<dynamic> produkList = args['produk'];
    int total = args['total'];
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
                          child: const Icon(Icons.share, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            child: ListView(
              padding: const EdgeInsets.all(14),
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              children: [
                _containerCustom(
                    120,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Penerima : Mas Bro',
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
                          hint: const Text("Pilih jasa kirim"),
                          isDense: true,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          value: _kurir,
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_outlined),
                          underline: Container(),
                          items: ["JNE Cargo", "J&T Cargo", "SiCepat Cargo"]
                              .map((value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _kurir = value.toString();
                              _isKurirSelected = true;
                            });
                          },
                        ),
                        Text(
                            _isKurirSelected == false
                                ? ""
                                : idrFormat.format(_listKurir[_kurir]),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black))
                      ],
                    )),
                ListView.builder(
                  primary: false,
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  shrinkWrap: true,
                  itemCount: produkList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.6, style: BorderStyle.solid)),
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 80,
                            width: 80,
                            child: FadeInImage(
                                image: NetworkImage(produkList[index]['gambar'],
                                    scale: 0.4),
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    produkList[index]['nama'],
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${produkList[index]['jumlah'].toString()} X ${idrFormat.format(produkList[index]['harga'])}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
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
                      hint: const Text("Pilih Metode Pembayaran"),
                      isDense: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      value: _metpem,
                      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                      underline: Container(),
                      items:
                          ["BRI", "BNI", "BCA", "Mandiri", "BTN"].map((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: Colors.black)));
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
                      decoration: const InputDecoration(
                          hintText: "Masukkan Kode Voucher",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal)),
                      cursorColor: Colors.brown[200],
                      style: const TextStyle(
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
                            const Text('Subtotal',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(idrFormat.format(total),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Jasa Kirim',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                _isKurirSelected == false
                                    ? ""
                                    : idrFormat.format(_listKurir[_kurir]),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                idrFormat.format(_isKurirSelected == false
                                    ? total
                                    : (_listKurir[_kurir] as int) + total),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/transaksi', (_) => false),
                  child: Container(
                    color: Colors.brown[300],
                    height: 50,
                    child: const Center(
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
