part of 'signincubit_cubit.dart';

@freezed
abstract class SignInCubitState with _$SignInCubitState {
  const factory SignInCubitState({
    required bool isLoading,
    required Option<Either<AuthFailure, Unit>> failureOrSuccessOption,
    required bool isSignedIn,
  }) = _Initial;

  factory SignInCubitState.initial() => SignInCubitState(
        isLoading: false,
        failureOrSuccessOption: none(), isSignedIn: false,
      );
}
