import '../../domain/credential.dart';
import 'package:async/async.dart';
import '../../domain/token.dart';

abstract class IAuthApi {
  Future<Result<String>> siginIn(Credential credential);
  Future<Result<String>> siginUp(Credential credential);
  Future<Result<bool>> siginOut(Token token);

}