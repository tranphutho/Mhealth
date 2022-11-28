import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/screens/AppointmentScreen.dart';
import 'package:singleclinic/screens/BookAppointment.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/order/order_screen.dart';
import 'package:singleclinic/utils/colors.dart';

import 'circle_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                        "H",
                        style: GoogleFonts.poppins().copyWith(fontSize: 19),
                      )),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "Himanshu",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "8607779866",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 19,
                              color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.pencil_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.bag)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(),
                      ));
                },
                title: Text(
                  "My Order",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.calendar)),
                title: Text(
                  "My Prescription",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading:
                    CircleWidget(child: Icon(CupertinoIcons.location_solid)),
                title: Text(
                  "Manage Address",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => BookAppointment()));
                },
                leading: CircleWidget(child: Icon(CupertinoIcons.archivebox)),
                title: Text(
                  "Book Appointment At Hospital",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.person)),
                title: Text(
                  "Our Doctors",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.group)),
                title: Text(
                  "Our Departments",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.capsule)),
                title: Text(
                  "Medicine",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.phone)),
                title: Text(
                  "Contact",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(Icons.security)),
                title: Text(
                  "Privacy Policy",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: CircleWidget(child: Icon(CupertinoIcons.doc)),
                title: Text(
                  "Terms & Condition",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  var shared = await SharedPreferences.getInstance();
                  shared.setBool("isLoggedIn", false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => LoginScreen()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "Logout",
                    style: GoogleFonts.poppins().copyWith(color: primaryColor),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
