import 'package:flutter/material.dart';

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
  late List<String>? images;

  void indicatorTap(toPage) {
    setState(() {
      _pageController.jumpToPage(toPage);
    });
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return GestureDetector(
        onTap: () {
          indicatorTap(index);
        },
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
                : Border(),
          ),
          child: Image.network(images![index], fit: BoxFit.fitWidth),
        ),
      );
    });
  }

  @override
  void initState() {
    _tes = ScrollController();
    _bar = AnimationController(vsync: this, duration: Duration(seconds: 0));
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
    images = [
      "https://i.postimg.cc/02mMvGry/8d0c23e40264722ac52cd3292c1133af.jpg",
      "https://i.postimg.cc/VNrN8TqT/b471033c94840e.png",
      "https://i.postimg.cc/sg4MQVYF/6664aaf6237b62de849db196444acb6b.jpg",
      "https://i.postimg.cc/pLH9L9nY/b471033c94840ef6696f31a2eaa45c9f.jpg",
      "https://i.postimg.cc/02mMvGry/8d0c23e40264722ac52cd3292c1133af.jpg"
    ];
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _tes!.addListener(() {
      _bar!.animateTo(_tes!.position.pixels / (screen.height / 5));
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: _tes,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: screen.width,
                    width: screen.width,
                    child: PageView.builder(
                        itemCount: images!.length,
                        pageSnapping: true,
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return Image.network(
                            images![pagePosition],
                            fit: BoxFit.fitWidth,
                          );
                        }),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.grey[200],
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: indicators(images!.length, activePage)),
                    ),
                  ),
                  Container(
                    width: screen.width,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.6, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Meja Laptop - Meja Kopi Kayu - Meja Belajar Anak',
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 8),
                        Text('Rp 59.900', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  Container(
                    width: screen.width,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 0.6, style: BorderStyle.solid))),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(images![1]),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Toko Primasakti',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('Bandung, Jawa Barat')
                          ],
                        ),
                        Flexible(child: Container()),
                        Icon(
                          Icons.chat,
                          color: Colors.brown[200],
                          size: 32,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screen.width,
                    //height: screen.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: const Border(
                            bottom: BorderSide(
                                width: 0.6, style: BorderStyle.solid))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Produk',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Divider(height: 10, color: Colors.brown[200]),
                        Text('Stok : 5'),
                        Divider(height: 10, color: Colors.brown[200]),
                        Text(
                            'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata')
                      ],
                    ),
                  ),
                  Container(
                    width: screen.width,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ulasan',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Divider(height: 10, color: Colors.brown[200]),
                        Flexible(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text('<Belum ada ulasan.>'),
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
                    SizedBox(height: MediaQuery.of(context).viewPadding.top),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: _bgcircle1!.value,
                                  offset: Offset.zero,
                                  blurStyle: BlurStyle.normal,
                                  blurRadius: 0.5)
                            ], shape: BoxShape.circle),
                            child:
                                Icon(Icons.arrow_back, color: _circle1!.value),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                                child: Icon(Icons.shopping_cart,
                                    color: _circle1!.value),
                              ),
                              Container(
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
                                child: Icon(Icons.mail_outline,
                                    color: _circle1!.value),
                              ),
                              Container(
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
                                child: Icon(Icons.notifications,
                                    color: _circle1!.value),
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
                Container(
                  height: 50,
                  width: 150,
                  color: Colors.pinkAccent,
                  padding: EdgeInsets.all(5),
                  child: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
