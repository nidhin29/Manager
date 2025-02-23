part of 'accounts_cubit.dart';

@freezed
abstract class AccountsState with _$AccountsState {
  const factory AccountsState({
    required bool isLoading,
    required Option<Either<MainFailure,Unit>> failureOrSuccessOption,
  }) = _Initial;

  factory  AccountsState.initial() => AccountsState(
        isLoading: false,
       failureOrSuccessOption: none(),
      );
}
