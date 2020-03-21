import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
class UserProductScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){})
        ],
      ),
      body: ListView.builder(itemBuilder: (_, i) => ,itemCount: productData.items.length,),
    );
  }
}
