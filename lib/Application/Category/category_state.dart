part of 'category_cubit.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState({
    required bool isLoading,
    required Option<Either<MainFailure, List<CategoryModel>>> categoriesFailureOrSuccessOption,
    required List<CategoryModel> categories,
  }) = _Initial;

  factory CategoryState.initial() => CategoryState(
        isLoading: false,
        categories: [], categoriesFailureOrSuccessOption: none(),
      );
}
