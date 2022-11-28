import 'package:singleclinic/main.dart';
import 'package:singleclinic/screens/SplashScreen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/screens/hospital/hospital_list_screen.dart';

class Routes {
  static var routes = {
    RootScreen.routeName: (context) => RootScreen(),
    SplashScreen.routeName: (context) => SplashScreen(),
    HospitalListScreen.routeName: (context) => HospitalListScreen(),
    DoctorsListScreen.routeName: (context) => DoctorsListScreen(),
  };
}
