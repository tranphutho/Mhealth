import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsScreen({Key key, this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 300.0,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.7),
              items: [0, 1, 2]
                  .map((e) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Image.network(
                            getImageUrl(hospital.logo),
                            fit: BoxFit.cover,
                          ).p(5),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),

            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.location),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Address",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      hospital.address,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ).px(30),
                  ),
                ],
              ).p(5),
            ),

            //Phone No
            SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.phone),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Phone",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    hospital.phone,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ).px(30),
                ],
              ).p(5),
            ),

            //  Departments
            SizedBox(
              height: 15,
            ),
            Text("Our Departments").px(5),
            SizedBox(
              height: 3,
            ),

            SizedBox
              (
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorsListScreen(
                                    filtersMap: {
                                      "department_id":
                                          hospital.departments[index].id.toString()
                                    })));
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: CircleBorder(),
                        child: IconButton(
                          iconSize: 40,
                          icon: Image.network(getDepartmentImageUrl(
                                  hospital.departments[index].image))
                              .p(5),
                        ),
                      ),
                      Text(
                        hospital.departments[index].name,
                        style: GoogleFonts.poppins(fontSize: 11),
                      )
                    ],
                  ).px(10),
                ),
                itemCount: hospital.departments.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
