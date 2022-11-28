import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/modals/order_model.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/services/api_service.dart';

class OrderModel extends Model {
  static OrderModel of(BuildContext context) =>
      ScopedModel.of<OrderModel>(context);

  OrderModel._();

  static OrderModel instance = OrderModel._();
  OrderModel() {
    //getCartList();
  }
  List<Order> _order = [];
  List<Order> get order => _order;

  ApiService service = ApiService.instance;

  getSumAmount() {
    //cart.reduce((value, element) => null)
  }

  getCartList() async {
    _order = await service.getOrder();
    notifyListeners();
  }
}
