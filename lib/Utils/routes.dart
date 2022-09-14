
import 'package:montagem_web/Screens/price_screen.dart';
import 'package:montagem_web/Screens/production_screen.dart';

import '../Utils/exports.dart';
class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case "/login":
        return MaterialPageRoute(
            builder: (_) =>const LoginScreen()
        );
      case "/home":
        return MaterialPageRoute(
            builder: (_) => NavigationScreen(index: 0)
        );
      case "/price":
        return MaterialPageRoute(
            builder: (_) => PriceScreen(index: 4)
        );
      case "/prod":
        return MaterialPageRoute(
            builder: (_) => ProductionScreen(),
        );

      default :
        _erroRota();
    }
    return null;
  }
  static Route <dynamic> _erroRota(){
    return MaterialPageRoute(
        builder: (_){
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tela em desenvolvimento"),
            ),
            body: const Center(
              child: Text("Tela em desenvolvimento"),
            ),
          );
    });
  }
}