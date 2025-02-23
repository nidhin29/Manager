part of 'budget_cubit.dart';

@freezed
abstract class BudgetState with _$BudgetState {
  const factory BudgetState({
    required bool isLoading,
    required Option<BudgetModel> failureOrSuccessOption,
    required int total,
  }) = _Initial;

  factory BudgetState.initial() => BudgetState(
        isLoading: false,
        failureOrSuccessOption: none(),
        total: 0,
      );
}
