


import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/utils/constants.dart';


getImageUrl(fileName){
  return BASE_URL+"/public${fileName}";

}
getDoctorImageUrl(String fileName){
  return IMAGE_BASE_URL+"/doctor/${fileName}";
}
getHospitalImageUrl(String fileName){
  return IMAGE_BASE_URL+"/hospital/${fileName}";
}
getDepartmentImageUrl(String fileName){
  return IMAGE_BASE_URL+"/department/${fileName}";

}

Future<bool> isUserLoggedIn()async{
  var prefs=await SharedPreferences.getInstance();
  return prefs.getBool("isLoggedIn");

}