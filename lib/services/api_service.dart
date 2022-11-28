import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/modals/cart_model.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/modals/order_model.dart';
import 'package:singleclinic/modals/patient_model.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/utils/AppExceptions.dart';
import 'package:singleclinic/utils/constants.dart';

class ApiService {
  ApiService._();
  static final ApiService _instance = ApiService._();
  static get instance => _instance;

  Future<List<Department>> getDepartments() async {
    http.Response response = await http.get(Uri.parse(DEPARTMENTS));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']['data']
          .map<Department>((item) => Department.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Doctor>> getDoctors() async {
    http.Response response = await http.get(Uri.parse(DOCTORS));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']['data']
          .map<Doctor>((item) => Doctor.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Doctor>> getFilteredDoctors(var data) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    Uri uri = Uri.parse(DOCTORS).replace(queryParameters: data);
    print(uri.toString());
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);

      if (json['data']['last_page'] == (int.parse(data['page']) - 1)) {
        throw NoMoreResult();
      }
      return json['data']['data']
          .map<Doctor>((item) => Doctor.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Hospital>> getHospitals(var data) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.get(
        Uri.parse(HOSPITALS).replace(queryParameters: data),
        headers: headers);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      if (json['data']['last_page'] == (int.parse(data['page']) - 1)) {
        throw NoMoreResult();
      }
      return json['data']['data']
          .map<Hospital>((item) => Hospital.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  /*
  getProducts()

  data = {
  "category_id":2

  }*/
  Future<List<Product>> getProducts({data = const {}}) async {
    Uri uri = Uri.parse(PRODUCTS).replace(queryParameters: data);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']['data']
          .map<Product>((item) => Product.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Category>> getCategories() async {
    http.Response response = await http.get(Uri.parse(CATEGORIES));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Category>((item) => Category.fromMap(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Patient>> getPatients() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.get(Uri.parse(PATIENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Patient>((item) => Patient.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<List<Appointment>> getAppointment() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.get(Uri.parse(APPOINTMENTS), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data']
          .map<Appointment>((item) => Appointment.fromJson(item))
          .toList();
    }
    throw Exception("Error");
  }

  Future<ApointmentStatus> bookAppointment({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(Uri.parse(BOOK_APPOINTMENT),
        headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      return ApointmentStatus.fromJson(jsonDecode(response.body));
    }
    throw Exception("Error");
  }

  Future<List<Cart>> getCart() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.get(Uri.parse(CART), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
    }
    throw Exception("Error");
  }
/*
  data = {
  "id":2,

  }*/

  addToCart({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.post(Uri.parse(ADD_TO_CART), headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  setQuantity({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response =
        await http.post(Uri.parse(SET_QUANTITY), headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  removeFromCart({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(Uri.parse(REMOTE_FROM_CART),
        headers: headers, body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  confirmCashOnDelivery({data: const {}}) async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.post(
        Uri.parse(CONFIRM_CASH_ON_DELIVERY),
        headers: headers,
        body: data);
    print(response.body);

    if (response.statusCode == 200) {
      {
        var json = jsonDecode(response.body);
        print(response.body);
        //return json['data'].map<Cart>((item) => Cart.fromJson(item)).toList();
      }
    }
  }

  Future<List<Order>> getOrder() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token");
    var headers = {"Authorization": "Bearer ${token}"};
    http.Response response = await http.get(Uri.parse(ODER), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      return json['data'].map<Order>((item) => Order.fromJson(item)).toList();
    }
    throw Exception("Error");
  }
}
