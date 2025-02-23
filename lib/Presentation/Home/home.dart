import 'package:flutter/material.dart';
import 'package:manager/Presentation/Category/category.dart';
import 'package:manager/Presentation/Home/home1.dart';
import 'package:manager/Presentation/Transaction/transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

     List<Widget> pages = [
      const HomePage(),
      const TransactionPage(),
      const CategoryScreen(),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: pages[currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory, 
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (newIndex) {
                currentIndexNotifier.value = newIndex;
              },
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.grey[900],
              type: BottomNavigationBarType.fixed,
              enableFeedback: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.money),
                  label: 'Transaction',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
