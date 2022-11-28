import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String valQuantily = "1";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          product.name,
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              ProductModel productModel = ProductModel();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => ShopScreen(productMode: productModel)));
            },
            style: ElevatedButton.styleFrom(
                primary: primaryColor, padding: EdgeInsets.all(20)),
            child: Text("Continue Shopping",
                style: GoogleFonts.poppins().copyWith(color: Colors.white))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  height: 300.0,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.75),
              items: [0, 1, 2]
                  .map((e) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            getImageUrl(product.photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.name,
              style: GoogleFonts.poppins()
                  .copyWith(color: Colors.black, fontSize: 19),
            ),
            Text(
              product.type,
              style: GoogleFonts.poppins()
                  .copyWith(color: Colors.black, fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: Builder(builder: (context) {
                    return DropdownButton(
                      value: valQuantily,
                      items: List<String>.generate(
                              product.quantity, (int index) => '${index + 1}')
                          .map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(
                            val,
                            style: GoogleFonts.poppins()
                                .copyWith(color: Colors.black, fontSize: 17),
                          ),
                        );
                      }).toList(),
                      underline: SizedBox(),
                      isExpanded: true,
                      onChanged: (String value) {
                        valQuantily = value;
                        (context as Element).markNeedsBuild();
                      },
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    CartModel cartModel = CartModel();
                    cartModel.addToCart(product.id, int.parse(valQuantily));
                  },
                  child: Text("Add"),
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            Divider(),
            Text("Description"),
            SizedBox(
              height: 8,
            ),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}
