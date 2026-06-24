part of 'beneficary_cubit.dart';

@immutable
abstract class BeneficaryState {
  final bool isObscure;
  const BeneficaryState({this.isObscure = true});
}
class toogle extends BeneficaryState{
  const toogle({super.isObscure});
}

final class BeneficaryLoading extends BeneficaryState {}
final class BeneficarySuccess extends BeneficaryState{

}
class  BeneficaryFail extends BeneficaryState {
  final String message;
  const BeneficaryFail(this.message);
}
