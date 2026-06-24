abstract class RegisterDonatorState {}

class RegisterDonatoreInitial extends RegisterDonatorState {}

class RegisterDonatorLoading extends RegisterDonatorState {}

class RegisterDonatorSuccess extends RegisterDonatorState {}

class RegisterDonatorError extends RegisterDonatorState {
  final String message;
  RegisterDonatorError(this.message);
}
