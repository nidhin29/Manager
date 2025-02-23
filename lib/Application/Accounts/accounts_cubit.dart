import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Accounts/accounts_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';

part 'accounts_state.dart';
part 'accounts_cubit.freezed.dart';

@injectable
class AccountsCubit extends Cubit<AccountsState> {
  final AccountsService _accountsService;
  AccountsCubit(this._accountsService) : super(AccountsState.initial());

  Future<void> createAccount(AccountsModel account) async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess = await _accountsService.createAccount(account);

    emit(state.copyWith(
      isLoading: false,
      failureOrSuccessOption: some(failureOrSuccess),
    ));
  }



  Future<void> ensureInitialAccount() async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess = await _accountsService.ensureInitialAccount();

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

  
}
