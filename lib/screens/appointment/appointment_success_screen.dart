import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

class AppointmentSuccessScreen extends StatelessWidget {
  final ApointmentStatus status;

  const AppointmentSuccessScreen({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppointmentModel>(
      model: AppointmentModel(),
      child: Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: AppBar(
          title: Text(
            "Book Appointment",
            style: GoogleFonts.poppins().copyWith(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60,
                        ),
                        Text(
                          "Booking Successful",
                          style: GoogleFonts.poppins(fontSize: 28),
                        )
                      ],
                    ),
                    Text("Patient Details",style: GoogleFonts.poppins(fontSize: 28,fontWeight: FontWeight.w500),),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${status.patient.firstName} ${status.patient.lastName}"),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Age"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${status.patient.age}"),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Gender"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(status.patient.gender),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Location"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(status.patient.location),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Relation"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(status.patient.relation),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Class"),
                            ),
                          ]
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
