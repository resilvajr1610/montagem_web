import 'package:shared_preferences/shared_preferences.dart';

class PrefService{
  
  Future createCache(String password,email)async{
    
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    
    _preferences.setString('password', password);
    _preferences.setString('email', email);
  }
  
  Future readPassword(String password) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString('password');
    return cache;
  }

  Future readEmail(String email) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString('email');
    return cache;
  }

  Future removeCache() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('password');
  }
}