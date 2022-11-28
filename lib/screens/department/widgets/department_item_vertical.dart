import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/utils/colors.dart';

class DepartmentItemGrid extends StatelessWidget {
  final Map<String,String> data;
  const DepartmentItemGrid({Key key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: primaryColor,
        child: Column(
          children: [
            Image.asset(
              data['image'],
              scale: 0.7,
            ),
            Text(
                data['title'],
              style: GoogleFonts.poppins()
                  .copyWith(fontSize: 22, color: Colors.white),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "It of a ligand is the no. of lone pairs donated to the central meta",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins()
                    .copyWith(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
