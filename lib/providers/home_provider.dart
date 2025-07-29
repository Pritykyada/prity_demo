import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../services/product_service.dart';

class HomeProvider extends ChangeNotifier {
  final ProductService productService = ProductService();

  List<Product> products = [];
  List<Product> favorites = [];
  List<CartItem> cartItems = [];
  bool isLoading = false;
  String? error;

  double get cartTotal {
    return cartItems.fold(0, (total, item) => total + item.totalPrice);
  }
  int get cartItemCount {
    return cartItems.fold(0, (total, item) => total + item.quantity);
  }


  Future<void> loadProducts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await productService.getProducts();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(Product product) {
    if (favorites.contains(product)) {
      favorites.remove(product);
    } else {
      favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return favorites.contains(product);
  }

  void addToCart(Product product) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }
  int getProductQuantity(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      return cartItems[index].quantity;
    }
    return 0;
  }


  void updateCartItemQuantity(Product product, int quantity) {
    final index = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index] = cartItems[index].copyWith(quantity: quantity);
      }
      notifyListeners();
    }
  }

  // int _currentIndex = 0;
  //
  // int get currentIndex => _currentIndex;

  // void setCurrentIndex(int index) {
  //   _currentIndex = index;
  //   notifyListeners();
  // }
}