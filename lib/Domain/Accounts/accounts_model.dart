import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';

class AccountsModel {
  final String id;
  final String name;
  final List<TransactionModel> transactions;

  AccountsModel(
      {required this.id, required this.name, required this.transactions});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'transactions': transactions.map((t) => t.toMap()).toList(),
    };
  }

  factory AccountsModel.fromMap(Map<String, dynamic> map) {
    return AccountsModel(
      id: map['id'],
      name: map['name'],
      transactions: (map['transactions'] as List)
          .map((t) => TransactionModel.fromMap(t))
          .toList(),
    );
  }
}

class BudgetModel {
  final int amount;
  final DateTime date;
  final String frequency;

  BudgetModel({required this.amount, required this.date, required this.frequency});
}
