abstract class RegistervoulnteerState {}

class RegisterVoulnteerInitial extends RegistervoulnteerState {}

class RegisterVoulnteerLoading extends RegistervoulnteerState {}

class RegisterVoulnteerSuccess extends RegistervoulnteerState {}

class RegisterVoulnteerError extends RegistervoulnteerState {
  final String message;
  RegisterVoulnteerError(this.message);
}
