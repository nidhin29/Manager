import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Domain/Accounts/Category/category_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';
part 'create_state.dart';
part 'create_cubit.freezed.dart';

@injectable
class CreateCubit extends Cubit<CreateState> {
  final CategoryService _categoryService;
  CreateCubit(this._categoryService) : super(CreateState.initial());

   Future<void> createCategory(CategoryModel category) async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess = await _categoryService.createCategory(category);

    emit(state.copyWith(
      isLoading: false,
      failureOrSuccessOption: some(failureOrSuccess),
    ));

   failureOrSuccess.fold(
      (failure) => {},
      (success) => emit(state.copyWith(
      )),
    );
  }

  Future<void> deleteCategory(CategoryModel category) async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess = await _categoryService.deleteCategory(category);
    emit(state.copyWith(
        isLoading: false, failureOrSuccessOption: some(failureOrSuccess)));
    failureOrSuccess.fold(
      (failure) => null,
      (success) => emit(state.copyWith(
          )),
    );
  }
}
