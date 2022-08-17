


import 'Screens/price_screen.dart';

import 'Utils/exports.dart';

void main ()async{
  String route = '/login';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: DataTable2SimpleDemo(),
    initialRoute:route,
    onGenerateRoute: Routes.generateRoute,

  ));


}