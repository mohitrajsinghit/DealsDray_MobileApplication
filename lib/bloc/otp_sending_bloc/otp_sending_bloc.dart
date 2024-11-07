import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dealsdray/Repositories/otp_repository.dart';
import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_event.dart';
import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  final OTPRepository otpRepository;

  OTPBloc(this.otpRepository) : super(OTPInitial()) {
    on<SendOTP>((event, emit) async {
      emit(OTPLoading());
      try {
        final message = await otpRepository.sendOTP(event.mobileNumber, event.deviceId);
        emit(OTPSent(message));
      } catch (e) {
        emit(OTPError(e.toString()));
      }
    }
    );
  }
}
