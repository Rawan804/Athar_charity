part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  final bool isObscure;
  const LoginState({this.isObscure = true});
}
class toogle extends LoginState{
  const toogle({super.isObscure});
}


class LoginLoading extends LoginState {

}

class LoginSuccess extends LoginState {


}

class LoginFail extends LoginState {
  final String message;
  const LoginFail(this.message);
}
