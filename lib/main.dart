


import 'Utils/exports.dart';

void main ()async{
  String route = '/login';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: HistoryScreen (),
    initialRoute:route,
    onGenerateRoute: Routes.generateRoute,

  ));


}