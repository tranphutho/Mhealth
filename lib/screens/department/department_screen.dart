import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/screens/department/widgets/department_item_vertical.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/screens/hospital/widget/hospital_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

class DepartmentListScreen extends StatelessWidget {
  const DepartmentListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> data = <Map<String,String>>[
      {
        "title": "Dentist",
        "image": "assets/homescreen/dental.png",
      },
      {
        "title": "Cardiology",
        "image": "assets/homescreen/cardio.png",
      },
      {
        "title": "Urology",
        "image": "assets/homescreen/uro.png",
      },
      {
        "title": "Neurology",
        "image": "assets/homescreen/neuro.png",
      },{
        "title": "Henology",
        "image": "assets/homescreen/uro.png",
      },
    ];
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text("Our Departments",style: GoogleFonts.poppins().copyWith(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios,color:Colors.black,),

      ),

      body:GridView.builder(itemBuilder: (context,index)=>DepartmentItemGrid(data: data[index],),itemCount: data.length,gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 4,
          crossAxisCount:2 ,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),),
    );
  }
}
