part of 'transactioncreate_cubit.dart';

@freezed
abstract class TransactioncreateState with _$TransactioncreateState {
  const factory TransactioncreateState({
    required bool isLoading,
    required Option<Either<MainFailure, Unit>> failureOrSuccessOption,
  }) = _Initial;

  factory TransactioncreateState.initial() => TransactioncreateState(
        isLoading: false,
        failureOrSuccessOption: none(),
      );
}
