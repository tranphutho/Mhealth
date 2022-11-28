import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/drawer.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/cart/cart_screen.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_category_screen.dart';
import 'package:singleclinic/screens/shop/widgets/product_horizontal_item.dart';
import 'package:singleclinic/screens/shop/widgets/shop_category_item.dart';
import 'package:singleclinic/screens/shop/widgets/shop_search_bar.dart';
import 'package:singleclinic/utils/colors.dart';

class ShopScreen extends StatelessWidget {
  ProductModel productMode;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ShopScreen({Key key, this.productMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productMode == null) {
      productMode = ProductModel();
    }
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
      key: _scaffoldKey,
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffFAFAFA),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 30,
            color: primaryColor,
          ),
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
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: ScopedModel<ProductModel>(
          model: productMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShopSearchBar(),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => ShopCategoryScreen()));
                              },
                              child: Text("View all")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScopedModelDescendant<ProductModel>(
                          builder: (context, s, model) {
                        return ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShopCategoryItem(
                              category: model.categories[index],
                              onTap: () {
                                ProductModel.of(context).getProductsByCategory(
                                    model.categories[index].id.toString());
                                print(model.categories[index].id.toString());
                              },
                            ),
                          ),
                          itemCount: model.categories.length,
                          scrollDirection: Axis.horizontal,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              ScopedModelDescendant<ProductModel>(builder: (context, s, model) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ProductHorizontalItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ProductDetailsScreen(
                                    product: model.products[index],
                                  )));
                    },
                    product: model.products[index],
                  ),
                  itemCount: model.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
