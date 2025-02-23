part of 'accountscreate_cubit.dart';

@freezed
abstract class AccountscreateState with _$AccountscreateState {
  const factory AccountscreateState({
    required bool isLoading,
    required bool isLoadingForBudget,
    required Option<BudgetModel> failureOrSuccessOptionforBudget,
    required BudgetModel budget,
    required Option<Either<MainFailure, List<AccountsModel>>> failureOrSuccessOption,
    required List<AccountsModel> accounts,
  })= _Initial;

  factory AccountscreateState.initial() => AccountscreateState(
        isLoading: false,
        accounts: [], failureOrSuccessOption: none(), isLoadingForBudget: false, failureOrSuccessOptionforBudget: none(), budget: BudgetModel(amount: -1, date: DateTime.now(), frequency: '')

      );
}
