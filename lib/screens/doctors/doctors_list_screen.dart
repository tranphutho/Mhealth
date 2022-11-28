import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/scoped_models/hospital_scoped_model.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorsListScreen extends StatelessWidget {
  final Map<String, String> filtersMap;
  static const routeName = "DoctorsListScreen";

  const DoctorsListScreen({Key key, this.filtersMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text(
          "Doctors",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: ScopedModel<DoctorsScopedModel>(
          model: DoctorsScopedModel.instance,
          child: Builder(builder: (context) {
            print("Getting docotrs from doctors screen");
            DoctorsScopedModel.of(context).getDoctors(
                filtersMap == null ? <String, String>{} : filtersMap,
                isRefresh: true);
            return ScopedModelDescendant<DoctorsScopedModel>(
                builder: (context, _, model) {
              return model.doctorsList.length > 0
                  ? SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: model.doctorRefreshController,
                      onLoading: model.onFilteredLoad,
                      footer: LazyLoaderFooter(),
                      child: ListView.builder(
                        itemBuilder: (context, index) => DoctorItemVertical(
                          doctor: model.doctorsList[index],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => DoctorAppointmentScreen(
                                          doctor: model.doctorsList[index],
                                        )));
                          },
                        ),
                        itemCount: model.doctorsList.length,
                      ))
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            });
          })),
    );
  }
}
