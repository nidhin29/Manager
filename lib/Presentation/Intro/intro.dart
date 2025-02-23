import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/Presentation/Intro/widgets/onboarding.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  final List<Widget> pages = const [
    OnboardingPage(
      imagePath: 'assets/Graph.png',
      title: 'Track your spending habits\nwith Manager!',
      subtitle:
          'Enter your daily transactions to gain powerful\n insights into your spending habits.',
    ),
    OnboardingPage(
      imagePath: 'assets/PigBank.png',
      title: 'Welcome to Manager!',
      buttonText: 'Sign In with Google', subtitle: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

    controller.addListener(() {
      pageIndexNotifier.value = controller.page!.round();
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
          Positioned(
            left: 20.w,
            bottom: 20.w,
            child: ValueListenableBuilder<int>(
              valueListenable: pageIndexNotifier,
              builder: (context, value, child) {
                return Visibility(
                  visible: value > 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 98, 104),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        if (controller.page! > 0) {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: 20.w,
            child: ValueListenableBuilder<int>(
              valueListenable: pageIndexNotifier,
              builder: (context, value, child) {
                return Visibility(
                  visible: value < pages.length - 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 28, 98, 104),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        if (controller.page! < pages.length - 1) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
