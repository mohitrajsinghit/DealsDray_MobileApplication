import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = 'http://devapiv4.dealsdray.com/api/v2';

  Future<void> signUpWithReferral({
    required String email,
    required String password,
    required String referralCode,
    required String userId,
  }) async {
    final url = Uri.parse('$baseUrl/user/email/referral');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'referralCode': null,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 202) {
    } else {
      throw Exception('Failed to sign up with referral');
    }
  }
}
