import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavorites;

  ProductsGrid(this._showFavorites);
  @override
  Widget build(BuildContext context) {

    final providerData = Provider.of<ProductsProvider>(context);
    final products = _showFavorites? providerData.favoriteItems: providerData.items;


    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
//      The ChangeNotifierProvider provides the child widget with the necessary information needed
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
//        builder: (c) => products[index],
      value: products[index],
        child: ProductItem(
//          id: products[index].id,
//          title: products[index].title,
//          imageUrl: products[index].imageUrl,
            ),
      ),
      itemCount: products.length,
    );
  }
}
