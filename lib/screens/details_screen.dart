import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/constants.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/screens/update_product.dart';
import 'package:store_app/widgets/details/details_body.dart';

import '../widgets/button_widget.dart';

class DetailsScreen extends StatelessWidget {
  final Product? product;

  const DetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: detailsAppBar(context),
      body: SingleChildScrollView(
        child: DetailsBody(
          product: product!,
        ),
      ),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(right: kDefaultPadding),
        icon: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "هل انت متاكد تريد الحــذف",
                  content: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          nameButton: "yes",
                          voidCallBakElveatateButtonGM: () {
                            Navigator.pop(context);
                            for (int i = 0; i < products.length; i++) {
                              if (products[i].id == product!.id) {
                                products.removeAt(i);
                              }
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: ButtonWidget(
                          nameButton: "no",
                          voidCallBakElveatateButtonGM: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                    // ButtonWidget(),
                  ));
            },
            icon: Icon(Icons.delete, color: Colors.red)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateProduct(product: product!)));
            },
            icon: Icon(Icons.edit, color: kPrimaryColor)),
      ],
      centerTitle: false,
      title: Text(
        'رجوع',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
