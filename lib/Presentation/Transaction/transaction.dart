import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:manager/Application/Accounts/Create/accountscreate_cubit.dart';
import 'package:manager/Application/Accounts/Transaction/Create/transactioncreate_cubit.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';
import 'package:manager/Presentation/Home/transactionpop.dart';
import 'package:manager/Presentation/constants/const.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AccountscreateCubit>(context).getAccounts();
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<TransactioncreateCubit, TransactioncreateState>(
        listener: (context, state) {
           state.failureOrSuccessOption.fold(
              () => {},
              (either) => either.fold(
                (failure) => {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(failure.toString())),
                  )
                },
                (a) => {
                  BlocProvider.of<AccountscreateCubit>(context).getAccounts()
                },
              ),
            );
        },
        child: BlocConsumer<AccountscreateCubit, AccountscreateState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.teal),
              );
            }

            final transactions = state.accounts
                .firstWhere((element) => element.id == TokenManager().aid)
                .transactions;

            if (transactions.isEmpty) {
              return const Center(
                child: Text(
                  'No transactions found.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            // Group transactions by month and year
            final Map<String, List<TransactionModel>> transactionsByMonth = {};
            final currentYearMonth = DateTime.now();
            final formatter = DateFormat('MMMM');

            // Populate transactionsByMonth
            for (var transaction in transactions) {
              final date = DateTime.parse(transaction.date.toIso8601String());
              final monthYearKey = DateFormat('yyyy-MM').format(date);
              if (!transactionsByMonth.containsKey(monthYearKey)) {
                transactionsByMonth[monthYearKey] = [];
              }
              transactionsByMonth[monthYearKey]!.add(transaction);
            }

            // Generate keys for the current year and surrounding months
            final startMonth = DateTime(currentYearMonth.year, 1);
            final endMonth = DateTime(currentYearMonth.year, 12);
            final months = List.generate(
              endMonth.difference(startMonth).inDays ~/ 30 + 1,
              (index) {
                final month =
                    DateTime(startMonth.year, startMonth.month + index);
                return DateFormat('yyyy-MM').format(month);
              },
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight20,
                kheight20,
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    controller: PageController(initialPage: 0),
                    itemBuilder: (context, index) {
                      final monthKey = months[index];
                      final transactionList =
                          transactionsByMonth[monthKey] ?? [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Text(
                              formatter.format(DateTime.parse('$monthKey-01')),
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: transactionList.isEmpty
                                ? const Center(
                                    child: Text(
                                      'No data available.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: transactionList.length,
                                    itemBuilder: (context, transactionIndex) {
                                      final transaction =
                                          transactionList[transactionIndex];

                                      return Card(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            borderRadius:
                                                BorderRadius.circular(13.r),
                                          ),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 25.r,
                                              backgroundColor: Colors.teal,
                                              child: Text(
                                                transaction.date.day.toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            title: Text(
                                              transaction.purpose,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '₹${transaction.amount.toString()}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                                BlocProvider.of<
                                                            TransactioncreateCubit>(
                                                        context)
                                                    .deleteTransaction(
                                                        TransactionModel(
                                                            purpose: transaction
                                                                .purpose,
                                                            amount: transaction
                                                                .amount,
                                                            date: transaction
                                                                .date,
                                                            type: transaction
                                                                .type,
                                                            category:
                                                                transaction
                                                                    .category),
                                                        TokenManager().aid!);
                                              },
                                              icon: const Icon(Icons.delete),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        kheight10,
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const TransactionPopUp();
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
