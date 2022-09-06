import 'package:firebase_core/firebase_core.dart';
import 'Utils/exports.dart';

void main ()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBtY16j14a0_xGofTDmldBZBm5Mx7T0KYg",
        appId: "1:956932365970:web:0b5375e6846fd8931ed04b",
        measurementId: "G-8P1KW2H3H5",
        projectId: "montagem-471b6",
        storageBucket: "montagem-471b6.appspot.com",
        messagingSenderId: '956932365970',
      ),
  );

  String route = '/login';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: ProductionScreen(),
    initialRoute:route,
    onGenerateRoute: Routes.generateRoute,
  ));
}