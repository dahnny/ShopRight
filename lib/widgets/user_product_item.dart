import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context, listen: false);
    final scaffold = Scaffold.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
//                    this passes the id to the screen it is being pushed to
                    Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
                  },
                  color: Theme.of(context).primaryColor),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await productData.deleteProduct(id);
                  }catch(error){
                    scaffold.showSnackBar(SnackBar(content:Text("Delete failed!", textAlign: TextAlign.center,)));
                  }
                },
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
