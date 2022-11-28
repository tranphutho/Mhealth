import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/cart/cart_screen.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/screens/shop/widgets/shop_category_item.dart';
import 'package:singleclinic/screens/shop/widgets/shop_search_bar.dart';
import 'package:singleclinic/utils/colors.dart';

class ShopCategoryScreen extends StatelessWidget {
  const ShopCategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = <Map<String, String>>[
      {
        "title": "Personal Care",
        "image": "assets/homescreen/dental.png",
      },
      {
        "title": "Cardiology",
        "image": "assets/homescreen/cardio.png",
      },
      {
        "title": "Medicine",
        "image": "assets/homescreen/uro.png",
      },
      {
        "title": "Teeth",
        "image": "assets/homescreen/neuro.png",
      },
      {
        "title": "Insurance",
        "image": "assets/homescreen/uro.png",
      },
    ];
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFAFAFA),
        leading: Icon(
          Icons.menu,
          size: 35,
          color: primaryColor,
        ),
        title: Row(
          children: [
            Image.asset(
              "assets/icon.png",
              width: 30,
              height: 30,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("mHEALTH",
                    style: TextStyle(
                        color: Color(0xff9EA7B1),
                        fontWeight: FontWeight.bold,
                        fontFamily: "dyna")),
                Text(
                  "Living Healthier Together",
                  style: TextStyle(color: Color(0xff9EA7B1), fontSize: 14),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (con) => CartScreen()));
                },
                icon: Icon(
                  CupertinoIcons.bag,
                  color: primaryColor,
                  size: 35,
                )),
          )
        ],
      ),
      body: ScopedModel<ProductModel>(
        model: ProductModel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShopSearchBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Shop By Category",
                style: GoogleFonts.poppins().copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ScopedModelDescendant<ProductModel>(
                  builder: (context, s, model) {
                return GridView.builder(
                  itemBuilder: (context, index) => ShopCategoryItem(
                    category: model.categories[index],
                    onTap: () {
                      ProductModel productModel = ProductModel();
                      productModel.getProductsByCategory(
                          model.categories[index].id.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (con) => ShopScreen(
                                    productMode: productModel,
                                  )));
                    },
                  ),
                  itemCount: model.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1,
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
