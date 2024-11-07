abstract class OTPEvent  {
  List<Object?> get props => [];
}

class SendOTP extends OTPEvent {
  final String mobileNumber;
  final String deviceId;

  SendOTP({required this.mobileNumber, required this.deviceId});

  @override
  List<Object?> get props => [mobileNumber, deviceId];
}
