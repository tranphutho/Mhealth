import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class HospitalItemVertical extends StatelessWidget {
  final Hospital hospital;
  final Function onTap;
  const HospitalItemVertical({Key key,this.hospital,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:onTap,
      child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        getImageUrl(hospital.logo),
                        width: 50,
                        fit: BoxFit.cover,
                        height: 50,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       hospital.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                      Text("Address: "+hospital.address),
                      Text("Phone no : ${hospital.phone}"),
                      SizedBox(height: 8,),
                      Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(6)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
                          child: Text(
                            "Book Appointment",
                            style: GoogleFonts.poppins().copyWith(fontSize: 12,color: Colors.white),

                          ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_sharp,color: primaryColor,)),
                    IconButton(onPressed: (){}, icon: RotatedBox(child: Icon(Icons.arrow_circle_down,color: primaryColor,),quarterTurns: -1)),

                  ],
                )
              ],
            ),
          )),
    );
  }
}
