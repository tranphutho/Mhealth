import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/scoped_models/cart_scoped_model.dart';
import 'package:singleclinic/scoped_models/order_scoped_model.dart';
import 'package:singleclinic/screens/cart/widgets/cart_item_vertical_widget.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';

import '../../AllText.dart';
import '../../main.dart';
import 'widgets/cart_item_vertical_widget.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key key}) : super(key: key);
  //CartModel cartModel = CartModel();
  @override
  Widget build(BuildContext context) {
    //cartModel.getCartList();
    final address = TextEditingController();
    final city = TextEditingController();
    final zipCode = TextEditingController();
    return ScopedModel<OrderModel>(
        model: OrderModel.instance,
        child: Builder(builder: (context) {
          OrderModel.of(context).getCartList();
          return ScopedModelDescendant<OrderModel>(
              builder: (context, _, model) {
            return Scaffold(
              backgroundColor: Color(0xfff6f6f6),
              appBar: AppBar(
                title: Text(
                  "My Order",
                  style: GoogleFonts.poppins().copyWith(color: Colors.black),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) =>
                          CartItemVertical(order: model.order[index]),
                      itemCount: model.order.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
            );
          });
        }));
  }

  errorDialog(message, context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.error,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  processingDialog(message, context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LOADING),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: LIGHT_GREY_TEXT, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }
}
