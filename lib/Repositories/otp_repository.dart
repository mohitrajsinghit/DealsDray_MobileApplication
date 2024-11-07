import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPRepository {

  Future<String> sendOTP(String mobileNumber, String deviceId) async {
    final response = await http.post(
      Uri.parse("http://devapiv4.dealsdray.com/api/v2/user/otp"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'mobileNumber': mobileNumber,
        'deviceId': deviceId,
        
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'OTP Sent Successfully';
    } else {
      throw Exception('Failed to send OTP');
    }
  }
}
