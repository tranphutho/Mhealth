import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/common/widgets/drawer.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/DoctorsList.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/screens/BookAppointment.dart';
import 'package:singleclinic/screens/ChatScreen.dart';
import 'package:singleclinic/screens/DoctorDetail.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/extensions/padding.dart';

import 'components/brands_horizontal_slider.dart';
import 'components/doctors_horizontal_component.dart';
import 'components/hospitals_horizontal_list.dart';
import 'components/medicine_horizontal_list.dart';
import 'components/our_departmetns_comp.dart';
import 'components/search_area.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  DoctorsList doctorsList;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  List<InnerData> myList = [];

  String nextUrl = "";
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  String myUid = "";
  Timer timer;

  bool isLoggedIn = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      setState(() {
        isLoggedIn = value.getBool("isLoggedIn") ?? false;
        myUid = value.getString("uid");
      });
    }).then((value) {
      if (myUid != null) {
        updateUserPresence();
      }
    });

    FirebaseMessaging.onMessage.listen((event) async {
      print("\n\nonMessage: $event");
      print("\nchannel: ${event.notification}");
      await SharedPreferences.getInstance().then((value) {
        print(value.get(event.data['uid']) ?? "does not exist");
        if (value.get(event.data['uid']) ?? false) {
          notificationHelper.showMessagingNotification(
              data: event.data, context2: context);
        }
      });
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Home building");
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: LIGHT_GREY_SCREEN_BG,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff00BE9C),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 35,
            ),
          ),
          title: Row(
            children: [
              Image.asset(
                "assets/icon.png",
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("mHEALTH",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "dyna")),
                  Text(
                    "Living Healthier Together",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: DrawerWidget(),
        body: body(),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          SearchArea(
            isLoggedIn: isLoggedIn,
          ),

          OurDepartments(),

          /*Book appointment at hospital*/
          HospitalsComp(),

          /*Meet doctors*/
          DoctorsHorizontalList(),

          /*Become seller and upload precrition*/

          HeadingTile(
            title: "Medicine",
            route: "",
          ),

          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [_becomeSellerWidget(), _uploadPrescriptionWidget()],
            ),
          ).p(8),

          /*Buy Medicine online*/

          MedicineHorizontalList(),
          /*Trusted by comapny*/
          BrandsHorizontalSlider(),

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         DOCTOR_LIST,
          //         style: TextStyle(
          //             color: BLACK, fontSize: 17, fontWeight: FontWeight.w700),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => DoctorList()));
          //         },
          //         child: Text(
          //           SEE_ALL,
          //           style: TextStyle(
          //               color: NAVY_BLUE,
          //               fontSize: 13,
          //               fontWeight: FontWeight.w700),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // doctorsList == null
          //     ? Container()
          //     : ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: myList.length,
          //         physics: ClampingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return doctorDetailTile(
          //             imageUrl: myList[index].image,
          //             name: myList[index].name,
          //             department: myList[index].departmentName,
          //             aboutUs: myList[index].aboutUs,
          //             id: myList[index].id,
          //           );
          //         },
          //       ),
          // nextUrl != "null"
          //     ? Padding(
          //         padding: const EdgeInsets.all(50.0),
          //         child: CircularProgressIndicator(
          //           strokeWidth: 2,
          //         ),
          //       )
          //     : Container(),
        ],
      ),
    );
  }

  doctorDetailTile(
      {String imageUrl,
      String name,
      String department,
      String aboutUs,
      int id}) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DoctorDetails(id)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: LIGHT_GREY, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: 72,
                  width: 72,
                  fit: BoxFit.cover,
                  imageUrl: Uri.parse(imageUrl).toString(),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                          height: 75,
                          width: 75,
                          child: Center(child: Icon(Icons.image))),
                  errorWidget: (context, url, error) => Container(
                    height: 75,
                    width: 75,
                    child: Center(
                      child: Icon(Icons.broken_image_rounded),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: BLACK,
                        fontSize: 17,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: LIME,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      child: Text(
                        department,
                        style: TextStyle(
                            color: WHITE,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          aboutUs,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: LIGHT_GREY_TEXT,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
        margin: EdgeInsets.fromLTRB(16, 6, 16, 6),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print("\n\nLifecycle state $state");

    if (state == AppLifecycleState.resumed) {
      updateUserPresence();
    } else {
      if (timer != null) {
        timer.cancel();
      }
      Map<String, dynamic> presenceStatusFalse = {
        'presence': false,
        'last_seen': DateTime.now().toUtc().toString(),
      };

      if (myUid != null) {
        await databaseReference
            .child(myUid)
            .update(presenceStatusFalse)
            .whenComplete(() => print('Updated your presence.'))
            .catchError((e) => print(e));
      }
    }
  }

  checkIfLoggedInFromAnotherDevice() async {}

  updateUserPresence() async {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
      'last_seen': DateTime.now().toUtc().toString(),
    };

    await databaseReference
        .child(myUid)
        .update(presenceStatusTrue)
        .whenComplete(() => print('Updated your presence.'))
        .catchError((e) => print(e));

    Map<String, dynamic> presenceStatusFalse = {
      'presence': false,
      'last_seen': DateTime.now().toUtc().toString(),
    };

    databaseReference.child(myUid).onDisconnect().update(presenceStatusFalse);
  }

  updatePreferenceAgainAndAgain() {
    Map<String, dynamic> presenceStatusTrue = {
      'presence': true,
      'connections': true,
      'last_seen': DateTime.now().toString(),
    };

    databaseReference.child(myUid).update(presenceStatusTrue).whenComplete(() {
      updateUserPresence();
      print('Updated your presence.');
    }).catchError((e) => print(e));
  }

  alertDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: _willPopScope,
            child: AlertDialog(
              title: Text("Log Out"),
              content: Text("Your account is logged In from another device"),
              actions: [
                TextButton(
                  child: Text("ok"),
                  onPressed: () async {},
                )
              ],
            ),
          );
        });
  }

  Future<bool> _willPopScope() async {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    return false;
  }

  Widget _becomeSellerWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1607619056574-7b8d3ee536b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGlsbHN8ZW58MHx8MHx8&w=1000&q=80",
                    width: 130,
                    height: 90,
                    fit: BoxFit.cover,
                  )),
              Container(
                height: 90,
                width: 130,
                child: Center(
                    child: Text(
                  "Become a Seller",
                  style: TextStyle(color: Colors.white),
                )),
                color: Colors.black.withOpacity(0.4),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 120,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(4)),
            child: Center(
                child: Text(
              "Register Now",
              style: TextStyle(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }

  Widget _uploadPrescriptionWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://images.mid-day.com/images/images/2022/apr/Pills-a_d.jpg",
                    width: 130,
                    height: 90,
                    fit: BoxFit.cover,
                  )),
              Container(
                height: 90,
                width: 130,
                child: Center(
                    child: Text(
                  "Upload Prescription",
                  style: TextStyle(color: Colors.white),
                )),
                color: Colors.black.withOpacity(0.4),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 120,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(4)),
            child: Center(
                child: Text(
              "Upload Now",
              style: TextStyle(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }
}
