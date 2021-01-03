import 'package:async/async.dart';
import 'package:auth/auth.dart';
import 'package:auth/models/user.dart';
import 'package:cubit/cubit.dart';

import 'package:roadmap/cashe/locale_store_intrface_contract.dart';
import '../../state_mangement/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;
  AuthCubit(this.localStore) : super(InitialState());

  signin(IAuthService authService) async {
    _startLoading();
    final result = await authService.signIn();
    _setResultOfAuthState(result);
  }

  signout(IAuthService authService) async {
    _startLoading();
    final token = await localStore.fetch();
    final result = await authService.signOut(token);
    if (result.asValue.value) {
      localStore.delete(token);
      emit(SignOutSuccessState());
    } else {
      emit(ErrorState('Error signing out'));
    }
  }

  signup(ISignUpService signUpService, User user) async {
    _startLoading();
    final result = await signUpService.signUp(
      user.name,
      user.email,
      user.password,
    );
    _setResultOfAuthState(result);
  }

  void _setResultOfAuthState(Result<Token> result) {
    if (result.asError != null) {
      emit(ErrorState(result.asError.error));
      return;
    }
    emit(AuthSuccessState(result.asValue.value));
  }

  void _startLoading() {
    emit(LoadingState());
  }
}
