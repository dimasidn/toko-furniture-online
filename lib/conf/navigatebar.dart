import 'package:flutter/material.dart';

List<dynamic> _routesList = [
  [Icons.home_outlined, Icons.home, "/dashboard"],
  [Icons.favorite_border, Icons.favorite, "/wishlist"],
  [Icons.local_shipping_outlined, Icons.local_shipping, "/transaksi"],
  [Icons.account_circle_outlined, Icons.account_circle, "/profil"]
];

Widget navbarCustomContainer(BuildContext context, int currentIndex) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(
                color: Colors.grey.shade500,
                width: 1,
                style: BorderStyle.solid))),
    child: Row(
      children: List<Widget>.generate(_routesList.length, (index) {
        return SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: double.infinity,
            child: Center(
                child: IconButton(
                    splashRadius: 1,
                    onPressed: currentIndex == index
                        ? () {}
                        : () => Navigator.pushReplacementNamed(
                            context, _routesList[index][2]),
                    icon: currentIndex == index
                        ? Icon(_routesList[index][1], color: Colors.pinkAccent)
                        : Icon(_routesList[index][0],
                            color: Colors.brown[200]))));
      }),
    ),
  );
}
