import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _customWidgetGridView(context, String namaBarang, String hargaBarang) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(namaBarang),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rp" + hargaBarang),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text("GAMBAR " + namaBarang),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.view_day), label: 'Feed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics), label: 'Analytics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts), label: 'Accounts'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More')
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          currentIndex: 0,
          selectedItemColor: Color.fromARGB(255, 94, 0, 202),
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedFontSize: 10,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Produk Tersedia",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    primary: true,
                    shrinkWrap: true,
                    childAspectRatio: 1.8,
                    padding: const EdgeInsets.all(50),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      _customWidgetGridView(context, 'Furniture 1', '900.000'),
                      _customWidgetGridView(context, 'Furniture 2', '800.000'),
                      _customWidgetGridView(
                          context, 'Furniture 3', '1.200.000'),
                      _customWidgetGridView(context, 'Furniture 4', '500.000'),
                      _customWidgetGridView(
                          context, 'Furniture 5', '4.000.000'),
                      _customWidgetGridView(
                          context, 'Furniture 6', '10.000.000'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
