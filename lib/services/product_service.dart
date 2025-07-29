import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/product.dart';
import 'api_services.dart';

class ProductService {
  final ApiServices _apiServices = ApiServices();
  final Box _box = Hive.box('productsBox');

  Future<List<Product>> getProducts() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      return await _fetchFromApi();
    } else {
      final localData = _getProductsFromHive();
      if (localData.isEmpty) {
        throw Exception('No Internet and No Local Data Available');
      }
      return localData;
    }
  }

  Future<List<Product>> _fetchFromApi() async {
    try {
      final response = await _apiServices.get(endpoint: '/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        await _box.put('products', jsonEncode(data));
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        return _getProductsFromHive();
      }
    } catch (e) {
      return _getProductsFromHive();
    }
  }

  List<Product> _getProductsFromHive() {
    final String? jsonString = _box.get('products');
    if (jsonString != null) {
      final List<dynamic> data = jsonDecode(jsonString);
      return data.map((json) => Product.fromJson(json)).toList();
    }
    return [];
  }
}