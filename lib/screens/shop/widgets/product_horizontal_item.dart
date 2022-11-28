import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/utils/helper.dart';


class ProductHorizontalItem extends StatelessWidget {
  final Function onTap;
  final Product product;
  const ProductHorizontalItem({Key key,this.onTap,this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),

        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Image.network(getImageUrl(product.photo),height: 130,)),
                ],
              ),
              Spacer(),
              Text(product.name,style: GoogleFonts.poppins(fontSize: 20).copyWith(),textAlign: TextAlign.start,),
              Text("\$${product.price}",style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.w500).copyWith(),)
            ],
          ),
        ),


      ),
    );
  }
}
