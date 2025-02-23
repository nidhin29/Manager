import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/Application/SignIn/signincubit_cubit.dart';
import 'package:manager/Presentation/Home/home.dart';
import 'package:manager/Presentation/Intro/intro.dart';
import 'package:manager/Presentation/constants/const.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      // ignore: use_build_context_synchronously
      BlocProvider.of<SignInCubit>(context).getSignedInUser();
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<SignInCubit, SignInCubitState>(
        listener: (context, state) {
          state.isSignedIn
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
              : Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const IntroPage()));
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets\\logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              kheight10,
              const Text(
                'Manager',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
