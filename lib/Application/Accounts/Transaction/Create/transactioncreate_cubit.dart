import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Domain/Accounts/accounts_service.dart';
import 'package:manager/Domain/Failure/main_failure.dart';

part 'transactioncreate_state.dart';
part 'transactioncreate_cubit.freezed.dart';

@injectable
class TransactioncreateCubit extends Cubit<TransactioncreateState> {
  final AccountsService _accountsService;
  TransactioncreateCubit(this._accountsService)
      : super(TransactioncreateState.initial());

  Future<void> createTransaction(
      TransactionModel trasaction, String accountid) async {
        log(trasaction.toString());
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess =
        await _accountsService.addTransaction(trasaction, accountid);
    log(failureOrSuccess.toString());
    emit(state.copyWith(
      isLoading: false,
      failureOrSuccessOption: some(failureOrSuccess),
    ));
  }

  Future<void> deleteTransaction(
      TransactionModel trasaction, String accountid) async {
    emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
    final failureOrSuccess =
        await _accountsService.deleteTransaction(trasaction, accountid);
    emit(state.copyWith(
        isLoading: false, failureOrSuccessOption: some(failureOrSuccess)));
  }
}
