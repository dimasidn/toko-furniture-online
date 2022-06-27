import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final idrFormat =
      NumberFormat.currency(locale: 'id_ID', name: "Rp ", decimalDigits: 0);
  List? data;

  @override
  void initState() {
    data = [
      ['Meja makan limited edition sdsd wwwdsds fsdfdsd', 'Surabaya', 8454211],
      ['Kursi makan kayu jati', 'Semarang', 5784448],
      ['Lemari pakaian Ukir asli jogja', 'Yogyakarta', 4544444],
      ['Rak sepatu asli original', 'Kudus', 2254587],
      ['ProdukProduk_produk xyz zz', 'Gresik', 2651646],
      ['ProdukProduk_produk klm zz', 'Karanganyar', 2651646],
      ['ProdukProduk_produk jkl zz', 'Boyolali', 2651646],
      ['ProdukProduk_produk opq zz', 'Klaten', 2651646],
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.brown[200]),
          height: MediaQuery.of(context).viewPadding.top + 50,
          width: screen.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              Row(
                children: const [
                  SizedBox(width: 40),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Keinginan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: GridView.builder(
              shrinkWrap: false,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  mainAxisExtent: 300),
              itemCount: data?.length,
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
                              child: Center(
                                  child: Text("Gambar ke-${index + 1}")))),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data?[index][0],
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(idrFormat.format(data?[index][2])),
                              Text(data?[index][1]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
