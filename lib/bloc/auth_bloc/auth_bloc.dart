import 'package:dealsdray/Repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpWithReferralEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await authRepository.signUpWithReferral(
          email: event.email,
          password: event.password,
          referralCode: event.referralCode,
          userId: event.userId,
        );
        emit(const AuthSuccess('Sign up successful'));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
