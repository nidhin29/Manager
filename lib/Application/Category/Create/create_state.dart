part of 'create_cubit.dart';

@freezed
abstract class CreateState with _$CreateState {
  const factory CreateState({
    required bool isLoading,
    required Option<Either<MainFailure, Unit>> failureOrSuccessOption,
  }) = _Initial;

  factory CreateState.initial() => CreateState(
        isLoading: false,
        failureOrSuccessOption: none(),
      );
}
