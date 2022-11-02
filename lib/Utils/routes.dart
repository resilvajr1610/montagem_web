
import 'package:montagem_web/Models/assembly_list_model.dart';
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
      case "/prod":
        return MaterialPageRoute(
            builder: (_) => ProductionScreen(args as String),
        );
      case "/assembly":
        return MaterialPageRoute(
          builder: (_) => AssemblyScreen(id: '',),
        );
      case "/pendencies":
        return MaterialPageRoute(
          builder: (_) => PendenciesScreen(),
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