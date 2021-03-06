// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart' as ProductCategory;
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  final ProductCategory.Category category;

  const HomePage({this.category: ProductCategory.Category.all});

  List<Card> _buildGridCards(BuildContext context) {
    List<ProductCategory.Product> products =
        ProductsRepository.loadProducts(ProductCategory.Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AsymmetricView(products: ProductsRepository.loadProducts(category));
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.menu,
    //         semanticLabel: 'menu',
    //       ),
    //       onPressed: () {
    //         print('Menu button');
    //       },
    //     ),
    //     title: Text('SHRINE'),
    //     actions: <Widget>[
    //       IconButton(
    //         icon: Icon(
    //           Icons.search,
    //           semanticLabel: 'search',
    //         ),
    //         onPressed: () {
    //           print('Search button');
    //         },
    //       ),
    //       IconButton(
    //         icon: Icon(
    //           Icons.tune,
    //           semanticLabel: 'filter',
    //         ),
    //         onPressed: () {
    //           print('Filter button');
    //         },
    //       )
    //     ],
    //   ),
    //   // TODO: Add a grid view (102)
    //   body: GridView.count(
    //     crossAxisCount: 2,
    //     padding: EdgeInsets.all(16.0),
    //     childAspectRatio: 8.0 / 9.0,
    //     children: _buildGridCards(context),
    //   ),
    //   resizeToAvoidBottomInset: false,
    // );
  }
}
