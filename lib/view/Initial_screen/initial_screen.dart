import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_event.dart';
import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_state.dart';
import 'package:dealsdray/view/Initial_screen/otp_verification.dart';
import 'package:dealsdray/view/registration_screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dealsdray/Repositories/otp_repository.dart';
import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  List<bool> isSelected = [true, false];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OTPBloc(OTPRepository()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: BlocListener<OTPBloc, OTPState>(
          listener: (context, state) {
            if (state is OTPSent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => OTPVerificationScreen(
                        phoneNumber: _phoneController.text)),
              );
            } else if (state is OTPError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90.h,
                  width: 80.w,
                  child: Image.asset(
                    'assets/images/dealdraylogo.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  'DealsDray',
                  style: TextStyle(fontSize: 35.sp, color: Colors.grey.shade200),
                ),
                SizedBox(height: 20.h),
                ToggleButtons(
                  isSelected: isSelected,
                  borderRadius: BorderRadius.circular(30),
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    });
            
                    if (isSelected[1]) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    }
                  },
                  fillColor: Colors.red,
                  selectedColor: Colors.white,
                  color: Colors.black,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: const Text('Phone'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: const Text('Email'),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Glad to see you!',
                      style:
                          TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    const Text(
                      'Please provide your phone number',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(left: 75.w, right: 75.w),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length != 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<OTPBloc, OTPState>(
                  builder: (context, state) {
                    if (state is OTPLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 80.w, vertical: 15.h),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<OTPBloc>(context).add(
                            SendOTP(
                                mobileNumber: _phoneController.text,
                                deviceId: '62b341aeb0ab5ebe28a758a3'),
                          );
                        }
                      },
                      child: const Text(
                        'SEND CODE',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
