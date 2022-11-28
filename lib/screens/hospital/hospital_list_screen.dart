import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/scoped_models/hospital_scoped_model.dart';
import 'package:singleclinic/scoped_models/hospitals_model.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';
import 'package:singleclinic/screens/hospital/widget/hospital_item_widget_vertical.dart';
import 'package:singleclinic/utils/colors.dart';

import 'hospital_details_screen.dart';

class HospitalListScreen extends StatelessWidget {
  static const routeName = "hospitalList";

  const HospitalListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text(
          "Hospitals",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: ScopedModel<HospitalScopedModel>(
          model: HospitalScopedModel.instance,
          child: Builder(builder: (context) {
            HospitalScopedModel.of(context).getHospitalList({},isRefresh: true);
            return ScopedModelDescendant<HospitalScopedModel>(
                builder: (context, _, model) {
              return model.hospitalList.length > 0
                  ? SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: model.hospitalRefreshController,
                  onLoading: model.onReload,
                  footer: LazyLoaderFooter(),
                  child: ListView.builder(
                    itemBuilder: (context, index) => HospitalItemVertical(
                      hospital: model.hospitalList[index],
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>HospitalDetailsScreen(hospital: model.hospitalList[index],)));

                      },

                    ),
                    itemCount: model.hospitalList.length,
                  ))
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            });
          })),
    );
  }
}
