

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Domain/Accounts/Category/category_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';
part 'category_state.dart';
part 'category_cubit.freezed.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _categoryService;
  CategoryCubit(this._categoryService) : super(CategoryState.initial());

  Future<void> getCategories() async {
    emit(state.copyWith(
        isLoading: true, categoriesFailureOrSuccessOption: none()));

    final categories = await _categoryService.getCategories();

    emit(state.copyWith(
        isLoading: false,
        categories: categories.fold((l) => [], (r) => r),
        categoriesFailureOrSuccessOption: some(categories)));
  }
}
