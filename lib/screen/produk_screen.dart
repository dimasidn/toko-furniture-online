import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../conf/firestore.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({Key? key}) : super(key: key);

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen>
    with TickerProviderStateMixin {
  AnimationController? _bar;
  Animation? _warnabar, _shadowbar, _opacitysearchbar, _bgcircle1, _circle1;
  ScrollController? _tes;
  late PageController _pageController;
  int activePage = 0;
  Map<String, dynamic>? _tokoData;
  bool _showData = false;

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

  List<Widget> indicators(
      List<dynamic> pictures, int imagesLength, int currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return GestureDetector(
        onTap: () => setState(() {
          _pageController.jumpToPage(index);
        }),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(width: 0.6, style: BorderStyle.solid)),
          foregroundDecoration: BoxDecoration(
            border: currentIndex == index
                ? Border.all(
                    width: 4,
                    style: BorderStyle.solid,
                    color: Colors.pinkAccent.withOpacity(0.8))
                : const Border(),
          ),
          child: FadeInImage(
              image: NetworkImage(pictures[index]),
              placeholder: const AssetImage("assets/logo2.png"),
              fit: BoxFit.fitWidth,
              placeholderFit: BoxFit.contain,
              imageErrorBuilder: (context, exception, stackTrace) {
                return const Text("Cannot load image");
              }),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _tes = ScrollController();
    _bar = AnimationController(vsync: this, duration: Duration.zero);
    _warnabar =
        ColorTween(begin: Colors.white.withOpacity(0), end: Colors.white)
            .animate(_bar!);
    _shadowbar =
        ColorTween(begin: Colors.black38.withOpacity(0), end: Colors.black38)
            .animate(_bar!);
    _bgcircle1 = ColorTween(
            begin: Colors.pinkAccent.withOpacity(0.5),
            end: Colors.white.withOpacity(1))
        .animate(_bar!);
    _circle1 =
        ColorTween(begin: Colors.white, end: Colors.brown[200]).animate(_bar!);
    _opacitysearchbar = IntTween(begin: 0, end: 100).animate(_bar!);
    _pageController = PageController();
    Future.delayed(Duration.zero, () async {
      _tokoData = await Firestore.getData('database', 'toko');
      setState(() {
        _showData = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tes!.dispose();
    _bar!.dispose();
    _warnabar = null;
    _shadowbar = null;
    _bgcircle1 = null;
    _circle1 = null;
    _opacitysearchbar = null;
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _tes!.addListener(() {
      _bar!.animateTo(_tes!.position.pixels / (screen.height / 5));
    });
    final arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Map<String, dynamic>? args = arg['produk'];
    List<dynamic> argsGambar = args!['gambar'];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _showData == false
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _tes,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: screen.width,
                        width: screen.width,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: argsGambar.length,
                            pageSnapping: true,
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                activePage = page;
                              });
                            },
                            itemBuilder: (context, pagePosition) {
                              return FadeInImage(
                                  image: NetworkImage(argsGambar[pagePosition]),
                                  placeholder:
                                      const AssetImage("assets/logosearch.png"),
                                  fit: BoxFit.fitWidth,
                                  imageErrorBuilder:
                                      (context, exception, stackTrace) {
                                    return const Text("Cannot load image");
                                  });
                            }),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          color: Colors.grey[200],
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: indicators(
                                  argsGambar, argsGambar.length, activePage)),
                        ),
                      ),
                      Container(
                        width: screen.width,
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, style: BorderStyle.solid))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(args['nama'],
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 8),
                            Text(idrFormat.format(args['harga']),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        width: screen.width,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.6, style: BorderStyle.solid))),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              backgroundImage: NetworkImage(_tokoData!['data']
                                  [args['id_toko'] - 1]['gambar']),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _tokoData!['data'][args['id_toko'] - 1]
                                      ['nama'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(_tokoData!['data'][args['id_toko'] - 1]
                                    ['alamat'])
                              ],
                            ),
                            Flexible(child: Container()),
                            GestureDetector(
                              onTap: () => _snackBarCustom(
                                  message: 'Fitur dalam pengembangan :)',
                                  color: Colors.orange),
                              child: Icon(
                                Icons.chat,
                                color: Colors.brown[200],
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: screen.width,
                        //height: screen.width,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: const Border(
                                bottom: BorderSide(
                                    width: 0.6, style: BorderStyle.solid))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Detail Produk",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Divider(height: 10, color: Colors.brown[200]),
                            Text("Stok : ${args['stok'].toString()}",
                                style: const TextStyle(fontSize: 16)),
                            Divider(height: 10, color: Colors.brown[200]),
                            Text(args['deskripsi'],
                                style: const TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                      Container(
                        width: screen.width,
                        height: 120,
                        padding: const EdgeInsets.all(10),
                        color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ulasan',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Divider(height: 10, color: Colors.brown[200]),
                            Flexible(
                                child: Container(
                              alignment: Alignment.center,
                              child: const Text('<Belum ada ulasan>'),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedBuilder(
                    animation: _bar!,
                    builder: (context, child) => Container(
                      width: screen.width,
                      height: MediaQuery.of(context).viewPadding.top + 50,
                      decoration: BoxDecoration(
                          color: _warnabar!.value,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: _shadowbar!.value,
                                offset: Offset.zero,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2)
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).viewPadding.top),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration:
                                        BoxDecoration(boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: _bgcircle1!.value,
                                          offset: Offset.zero,
                                          blurStyle: BlurStyle.normal,
                                          blurRadius: 0.5)
                                    ], shape: BoxShape.circle),
                                    child: Icon(Icons.arrow_back,
                                        color: _circle1!.value),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Opacity(
                                  opacity: _opacitysearchbar!.value / 100,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Icon(
                                            Icons.search,
                                            size: 20,
                                            color: Colors.pinkAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                width: 160,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, '/keranjang'),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: _bgcircle1!.value,
                                                  offset: Offset.zero,
                                                  blurStyle: BlurStyle.normal,
                                                  blurRadius: 0.5)
                                            ],
                                            shape: BoxShape.circle),
                                        child: Icon(Icons.shopping_cart,
                                            color: _circle1!.value),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _snackBarCustom(
                                          message:
                                              'Fitur dalam pengembangan :)',
                                          color: Colors.orange),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: _bgcircle1!.value,
                                                  offset: Offset.zero,
                                                  blurStyle: BlurStyle.normal,
                                                  blurRadius: 0.5)
                                            ],
                                            shape: BoxShape.circle),
                                        child: Icon(Icons.mail_outline,
                                            color: _circle1!.value),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _snackBarCustom(
                                          message:
                                              'Fitur dalam pengembangan :)',
                                          color: Colors.orange),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: _bgcircle1!.value,
                                                  offset: Offset.zero,
                                                  blurStyle: BlurStyle.normal,
                                                  blurRadius: 0.5)
                                            ],
                                            shape: BoxShape.circle),
                                        child: Icon(Icons.notifications,
                                            color: _circle1!.value),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/checkout",
                              arguments: {
                                "produk": [
                                  {
                                    "nama": args['nama'],
                                    "harga": args['harga'],
                                    "jumlah": 1,
                                    "gambar": argsGambar[0]
                                  }
                                ],
                                "total": args['harga']
                              }),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.brown[200],
                            child: Text('Beli Sekarang',
                                style: TextStyle(
                                  color: Colors.brown[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _snackBarCustom(
                            message: 'Fitur dalam pengembangan :)',
                            color: Colors.orange),
                        child: Container(
                          height: 50,
                          width: 150,
                          color: Colors.pinkAccent,
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 30,
                          ),
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
