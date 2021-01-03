import 'package:auth/auth.dart';
import 'package:roadmap/cashe/locale_store_intrface_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CASHED_TOKEN = 'CASHED_TOKEN';
class LocalStore implements ILocalStore {
  final SharedPreferences sharedPreferences;
  LocalStore(this.sharedPreferences);


  @override
  delete(Token token) {
    sharedPreferences.remove(CASHED_TOKEN);
  }

  @override
  Future<Token> fetch() {
    final tokenStr = sharedPreferences.getString(CASHED_TOKEN);
    if(tokenStr != null) return Future.value(Token(tokenStr));

    return null;

  }

  @override
  Future save(Token token) {
   return sharedPreferences.setString(CASHED_TOKEN, token.value);
  }
  
}