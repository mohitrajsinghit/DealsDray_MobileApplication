import 'package:dealsdray/bloc/auth_bloc/auth_bloc.dart';
import 'package:dealsdray/bloc/auth_bloc/auth_event.dart';
import 'package:dealsdray/bloc/auth_bloc/auth_state.dart';
import 'package:dealsdray/view/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  bool _isPasswordVisible = false; 

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 90.h,
                        width: 80.w,
                        child: Image.asset(
                          'assets/images/dealdraylogo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'DealsDray',
                        style: TextStyle(
                            fontSize: 35.sp, color: Colors.grey.shade200),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Let's Begin!",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Please enter your credentials to proceed",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Your Email',
                        border: UnderlineInputBorder(),
                      ),
                      validator: _emailValidator,
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText:
                          !_isPasswordVisible, 
                      decoration: InputDecoration(
                        labelText: 'Create Password',
                        border: const UnderlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: _passwordValidator,
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _referralCodeController,
                      decoration: const InputDecoration(
                        labelText: 'Referral Code (Optional)',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.h, right: 10.w),
        child: SizedBox(
          width: 60.w,
          height: 50.h,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                BlocProvider.of<AuthBloc>(context).add(
                  SignUpWithReferralEvent(
                    email: _emailController.text,
                    password: _passwordController.text,
                    referralCode: _referralCodeController.text,
                    userId: '62a833766ec5dafd6780fc85',
                  ),
                );
              }
            },
            child: Icon(
              Icons.arrow_forward,
              size: 25.r,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
