import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/screens/appointment/appointment_success_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorAppointmentScreen({Key key, this.doctor}) : super(key: key);

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
        bottomNavigationBar: ScopedModelDescendant<AppointmentModel>(
            builder: (context, _, model) {
          return InkWell(
            onTap: () async {
              ApointmentStatus status = await model.bookAppointment(doctorId: doctor.id);
              Navigator.push(context, MaterialPageRoute(builder: (c)=>AppointmentSuccessScreen(status: status,)));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 60,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                "Book",
                style: GoogleFonts.poppins()
                    .copyWith(color: Colors.white, fontSize: 20),
              )),
            ),
          );
        }),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                    },
                  ),
                  DoctorItemVertical(doctor: doctor),
                  ScopedModelDescendant<AppointmentModel>(

                    builder: (context,_,model) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount:
                              doctor.todayAvailableTimes.availableTimes.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, childAspectRatio: 2 / 1),
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  String time = doctor
                                      .todayAvailableTimes.availableTimes[index];
                                  AppointmentModel.of(context).selectedTime = time;
                                  AppointmentModel.of(context).selectedDate = doctor
                                      .todayAvailableTimes.date.toString();
                                  model.notifyListeners();
                                },
                                child: Card(
                                  color: model.selectedTime==doctor
                                      .todayAvailableTimes.availableTimes[index]?Colors.black.withOpacity(0.1):Colors.white,
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                    doctor
                                        .todayAvailableTimes.availableTimes[index],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600),
                                  )),
                                )),
                              ));
                    }
                  ),
                  ScopedModelDescendant<AppointmentModel>(
                      builder: (context, _, model) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButton(
                          onChanged: (value) {
                            model.selectedPatient = model.patientsList
                                .firstWhere((element) => element.id == value);
                            model.notifyListeners();
                          },
                          value: model.selectedPatient != null
                              ? model.selectedPatient.id
                              : null,
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text("Select Patient Name"),
                          items: model.patientsList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.firstName),
                                    value: e.id,
                                  ))
                              .toList()),
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
