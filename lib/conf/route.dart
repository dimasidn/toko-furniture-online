import 'package:flutter/material.dart';
import '../screen/login_screen.dart';
import '../screen/checkout_screen.dart';
import '../screen/dashboard.dart';
import '../screen/keranjang_screen.dart';
import '../screen/pencarian_screen.dart';
import '../screen/produk_screen.dart';
import '../screen/profil_screen.dart';
import '../screen/signup_screen.dart';
import '../screen/transaksi_screen.dart';
import '../screen/wishlist_screen.dart';
import '../screen/profil/profil_edit_screen.dart';
import '../screen/profil/profil_settings_screen.dart';

Route<dynamic>? customRoute(RouteSettings pageprop) {
  dynamic screenName;
  switch (pageprop.name) {
    case "/wishlist":
      screenName = const WishlistScreen();
      break;
    case "/transaksi":
      screenName = const TransaksiScreen();
      break;
    case "/profil":
      screenName = const ProfilScreen();
      break;
    case "/profil_edit":
      screenName = const ProfilEditScreen();
      break;
    case "/profil_settings":
      screenName = const ProfilSettingsScreen();
      break;
    case "/produk":
      screenName = const ProdukScreen();
      break;
    case "/keranjang":
      screenName = const KeranjangScreen();
      break;
    case "/checkout":
      screenName = const CheckoutScreen();
      break;
    case "/pencarian":
      screenName = const PencarianScreen();
      break;
    case "/signup":
      screenName = const SignupScreen();
      break;
    case "/login":
      screenName = const LoginScreen();
      break;
    case "/dashboard":
    default:
      screenName = const HomeScreen();
      break;
  }
  return PageRouteBuilder(
      settings: pageprop, pageBuilder: (_, __, ___) => screenName);
}
