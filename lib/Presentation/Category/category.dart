

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/Application/Category/category_cubit.dart';
import 'package:manager/Presentation/Category/expense.dart';
import 'package:manager/Presentation/Category/income.dart';
import 'package:manager/Presentation/Home/categorypop.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CategoryCubit>(context).getCategories();  
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: const SizedBox(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 270.w),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                const TabBar(
                  labelColor: Colors.teal,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.teal,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'Income'),
                    Tab(text: 'Expense'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            IncomeCategory(),
            ExpenseCategory(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return CategoryPopUp();
              },
            ));
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
