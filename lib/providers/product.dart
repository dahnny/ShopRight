import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
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

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
//    The notifyListeners method is almost like the
//    setState class because it rebuilds widgets that look up to it
    notifyListeners();
  }
}
