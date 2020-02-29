import 'package:flutter/material.dart';

import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
//  final List<Product> loadedProducts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'MyShop',
      )),
      body: ProductsGrid(),
    );
  }
}


