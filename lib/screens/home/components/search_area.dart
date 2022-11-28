import 'package:flutter/material.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';

import '../../BookAppointment.dart';
import '../../LoginScreen.dart';

class SearchArea extends StatelessWidget {
  final bool isLoggedIn;
  const SearchArea({Key key, this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final search = TextEditingController();
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isLoggedIn
                  ? DoctorsListScreen(filtersMap: {"search": search.text})
                  : LoginScreen(),
            ));
      },
      child: Stack(
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xff00BE9C),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/homescreen/banner_image.png",
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
              bottom: 90,
              left: 10,
              child: Column(
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "mHEALTH",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "dyna"),
                  ),
                ],
              )),
          Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Center(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                    controller: search,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search doctors by name"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Icon(Icons.filter_list_outlined),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
