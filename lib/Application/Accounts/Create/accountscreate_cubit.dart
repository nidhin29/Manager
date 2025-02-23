import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Accounts/accounts_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';


part 'accountscreate_state.dart';
part 'accountscreate_cubit.freezed.dart';

@injectable
class AccountscreateCubit extends Cubit<AccountscreateState> {
  final AccountsService _accountsService;
  AccountscreateCubit(this._accountsService)
      : super(AccountscreateState.initial());

  Future<void> getAccounts() async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));

    final accounts = await _accountsService.getAccounts();

    emit(state.copyWith(
        isLoading: false,
        failureOrSuccessOption: some(accounts),
        accounts: accounts.fold((l) => [], (r) => r)));
  }

  
}
