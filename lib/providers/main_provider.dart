import 'package:flutter/material.dart';
import 'package:product_browser/screen/favirote/favorite_screen.dart';

import '../screen/cart/cart_screen.dart';
import '../screen/home/product_screen.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> screens = [const ProductScreen(), const CartScreen(),FavoriteScreen()];

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  final List<Map> bottomBarItems = [
    {
      "image": Icon(Icons.shopping_bag),
      "text": "Products",
      "screen": () => ProductScreen(),
    },
    {
      "image": Icon(Icons.shopping_bag),
      "text": 'Cart',
      "screen": () => CartScreen(),
    },
    {
      "image": Icon(Icons.favorite),
      "text": 'Favorite',
      "screen": () => FavoriteScreen(),
    },
  ];
}