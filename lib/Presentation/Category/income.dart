import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager/Application/Category/Create/create_cubit.dart';
import 'package:manager/Application/Category/category_cubit.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Presentation/constants/const.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight20,
        kheight20,
        kheight10,
        Expanded(
          child: BlocConsumer<CreateCubit, CreateState>(
            listener: (context, state) {
              state.failureOrSuccessOption.fold(() {}, (either) {
                either.fold((l) {}, (r) {
                  BlocProvider.of<CategoryCubit>(context).getCategories();
                });
              });
            },
            builder: (context, state) {
              return BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return state.categoriesFailureOrSuccessOption.fold(
                      () => Center(
                            child: Text(
                              'No Data',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                          ),
                      (a) => a.fold(
                          (l) => Center(
                                child: Text(
                                  'No Data',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                              ),
                          (r) => state.categories
                                      .where((element) =>
                                          element.type == CategoryType.income)
                                      .toList() ==
                                  []
                              ? Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                  ),
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    log(state.categories.toString());
                                    final incomeCategories = state.categories
                                        .where((category) =>
                                            category.type ==
                                            CategoryType.income)
                                        .toList();
                                    return Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          leading: Text(
                                            incomeCategories[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 14.sp),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<CreateCubit>(
                                                      context)
                                                  .deleteCategory(
                                                      incomeCategories[index]);
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return kheight20;
                                  },
                                  itemCount: state.categories
                                      .where((element) =>
                                          element.type == CategoryType.income)
                                      .length)));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
