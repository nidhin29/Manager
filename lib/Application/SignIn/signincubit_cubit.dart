import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Failure/auth_failure.dart';
import 'package:manager/Domain/SignIn/sign_in_service.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';
part 'signincubit_state.dart';
part 'signincubit_cubit.freezed.dart';

@injectable
class SignInCubit extends Cubit<SignInCubitState> {
  final SignInService _signInService;
  SignInCubit(this._signInService) : super(SignInCubitState.initial());

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess = await _signInService.signInWithGoogle();
    emit(state.copyWith(
        isLoading: false, failureOrSuccessOption: some(failureOrSuccess)));
    failureOrSuccess.fold((failure) => {}, (success) {
      emit(state.copyWith(isSignedIn: true));
      
      getSignedInUser();
    });
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    await _signInService.signOut();
    emit(state.copyWith(isLoading: false, isSignedIn: false));
  }

  Future<void> getSignedInUser() async {
    final user = await _signInService.getSignedInUser();
    if (user.isSome()) {
      TokenManager().setName(user.fold(() => '', (a) => a.name));
      TokenManager().setUser(user.fold(() => '', (a) => a.uid));
      TokenManager().setAid(user.fold(() => '', (a) => a.uid));
      log(TokenManager().name!);
    }
    emit(state.copyWith(isSignedIn: user.isSome()));
  }
}
