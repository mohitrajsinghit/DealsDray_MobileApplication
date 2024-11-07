abstract class OTPState {
  List<Object?> get props => [];
}

class OTPInitial extends OTPState {}

class OTPLoading extends OTPState {}

class OTPSent extends OTPState {
  final String message;

  OTPSent(this.message);

  @override
  List<Object?> get props => [message];
}

class OTPError extends OTPState {
  final String error;

  OTPError(this.error);

  @override
  List<Object?> get props => [error];
}
