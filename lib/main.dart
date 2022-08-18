


import 'Screens/price_screen.dart';

import 'Screens/production_screen.dart';
import 'Utils/exports.dart';

void main ()async{
  String route = '/login';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: ProductionScreen(),
    initialRoute:route,
    onGenerateRoute: Routes.generateRoute,

  ));


}