import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/Application/Accounts/accounts_cubit.dart';
import 'package:manager/Application/SignIn/signincubit_cubit.dart';
import 'package:manager/Presentation/Home/home.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String? buttonText;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInCubitState>(
      listener: (context, state) {
        state.failureOrSuccessOption.fold(
            () => {},
            (either) => either.fold(
                (failure) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(failure.toString())))
                    },
                (a) => {
                  BlocProvider.of<AccountsCubit>(context).ensureInitialAccount(),
                  Future.delayed(const Duration(seconds: 3)),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()))
                    }));
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 250.h),
              const SizedBox(height: 30),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              if (buttonText != null)
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SignInCubit>(context).signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 28, 98, 104), width: 2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/google.png', height: 30),
                        Text(
                          buttonText!,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 28, 98, 104)),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
