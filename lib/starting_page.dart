import 'package:dealsdray/Repositories/auth_repository.dart';
import 'package:dealsdray/Repositories/otp_repository.dart';
import 'package:dealsdray/bloc/home_bloc/home_bloc.dart';
import 'package:dealsdray/Repositories/api_repository.dart';
import 'package:dealsdray/bloc/otp_sending_bloc/otp_sending_bloc.dart';
import 'package:dealsdray/view/home_screen/home.dart';
import 'package:dealsdray/bloc/auth_bloc/auth_bloc.dart';
import 'package:dealsdray/view/Initial_screen/initial_screen.dart';
import 'package:dealsdray/view/registration_screen/registration.dart';
import 'package:dealsdray/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(ApiRepository()),
        ),
        BlocProvider(
         create: (context) => OTPBloc(OTPRepository()),
        ),
        
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            title: 'DealsDray',
            theme: ThemeData(
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/phone',
      builder: (BuildContext context, GoRouterState state) {
        return const PhoneNumberScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignupScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);

}
