import 'package:flutter/material.dart';

import '../../domain/credential.dart';
import '../../domain/auth_service_contract.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contract.dart';
import 'package:async/async.dart';

class EmailAuth implements IAuthService {
  final IAuthApi _api;
  Credential _credential;
  EmailAuth(this._api);

  void credential({@required String email, @required String password}) {
    _credential = Credential(
      type: AuthType.email,
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<Token>> signIn() async {
    assert(_credential != null);
    var result = await _api.siginIn(_credential);
    if (result.isError) return result.asError;
    return Result.value(Token(result.asValue.value));
  }

  @override
  Future<Result<bool>> signOut(Token token) async {
    return await _api.siginOut(token);
  }

  
}
