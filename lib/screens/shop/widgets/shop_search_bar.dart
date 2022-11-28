import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ShopSearchBar extends StatelessWidget {
  const ShopSearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Card(
        color: Colors.white,
        elevation: 0,
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          child: Row(
            children: [
              Icon(CupertinoIcons.search,color: Colors.black,),
              SizedBox(width: 8,),
              Expanded(child: Text("Search Medicine Or Tablet",style: GoogleFonts.poppins().copyWith(color: Colors.black.withOpacity(0.4),fontSize: 18),))
            ],
          ),
        ) ,
      ),
    );

  }
}
