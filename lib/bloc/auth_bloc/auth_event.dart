abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class SignUpWithReferralEvent extends AuthEvent {
  final String email;
  final String password;
  final String referralCode;
  final String userId;

  const SignUpWithReferralEvent({
    required this.email,
    required this.password,
    required this.referralCode,
    required this.userId,
  });

  @override
  List<Object> get props => [email, password, referralCode, userId];
}
