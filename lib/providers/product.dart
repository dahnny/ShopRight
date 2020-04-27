import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  void _favStatus(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
//    The notifyListeners method is almost like the
//    setState class because it rebuilds widgets that look up to it
    notifyListeners();
//    this url is used to store the favorite status of a particular user
    final url =
        "https://shopapp-de764.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
//      checks if the status code returns an error
      if (response.statusCode >= 400) {
        _favStatus(oldStatus);
      }
//      catch error and revert back
    } catch (error) {
      _favStatus(oldStatus);
    }
  }
}
