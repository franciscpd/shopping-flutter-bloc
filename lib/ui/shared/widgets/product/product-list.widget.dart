import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_bloc/models/product-list.model.dart';
import 'package:shopping_bloc/ui/shared/widgets/shared/loader.widget.dart';
import 'package:shopping_bloc/ui/shared/widgets/product/product-card.widget.dart';

class ProductList extends StatelessWidget {
  final List<ProductListModel> products;

  ProductList({@required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: Loader(
        object: products,
        callback: list,
      ),
    );
  }

  Widget list() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: ProductCard(
            item: products[index],
          ),
        );
      },
    );
  }
}
