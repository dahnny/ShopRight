import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
//  final List<Product> loadedProducts

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            actions: <Widget>[
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.Favorites) {
                      _showOnlyFavorites = true;
                    } else {
                      _showOnlyFavorites = false;
                    }
                  });
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) =>
                [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ],
              ),
              Consumer<Cart>(
                builder: (_, cartData, ch) =>
                    Badge(
                      child: ch,
                      value: cartData.itemCount.toString(),
                    ),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart), onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
              )

        ],
        title: Text(
          'MyShop',
        )),
    body: ProductsGrid(_showOnlyFavorites),
    );
    }
}
