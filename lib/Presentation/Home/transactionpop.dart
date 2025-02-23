import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/Application/Accounts/Create/accountscreate_cubit.dart';
import 'package:manager/Application/Accounts/Transaction/Create/transactioncreate_cubit.dart';
import 'package:manager/Application/Category/category_cubit.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';

ValueNotifier<CategoryType> selectedvalue = ValueNotifier(CategoryType.income);
String? newselected;
TextEditingController purposecontroller = TextEditingController();
TextEditingController amountcontroller = TextEditingController();

class TransactionPopUp extends StatefulWidget {
  const TransactionPopUp({super.key});

  @override
  State<TransactionPopUp> createState() => _TransactionPopUpState();
}

class _TransactionPopUpState extends State<TransactionPopUp> {
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();
    selectedvalue.value = CategoryType.income;
    newselected = null;
    purposecontroller.clear();
    amountcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<TransactioncreateCubit, TransactioncreateState>(
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
              () => {},
              (either) => either.fold(
                  (failure) => {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(failure.toString())))
                      },
                  (a) => {
                        BlocProvider.of<AccountscreateCubit>(context)
                            .getAccounts(),
                        Navigator.of(context).pop()
                      }));
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                child: TextFormField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: purposecontroller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Purpose',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
                child: TextFormField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 260),
                child: TextButton.icon(
                    onPressed: () async {
                      final selecteddatetemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now());
                      if (selecteddatetemp == null) {
                        return;
                      } else {
                        final now = DateTime.now();
                        final selectedDateWithTime = DateTime(
                          selecteddatetemp.year,
                          selecteddatetemp.month,
                          selecteddatetemp.day,
                          now.hour,
                          now.minute,
                          now.second,
                        );
                        setState(() {
                          _selectedDate = selectedDateWithTime;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.teal,
                    ),
                    label: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : _selectedDate!.toString(),
                      style: const TextStyle(color: Colors.teal),
                    )),
              ),
              const Row(
                children: [
                  Radiobutton(title: 'Income', type: CategoryType.income),
                  Radiobutton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
              ValueListenableBuilder(
                  valueListenable: selectedvalue,
                  builder:
                      (BuildContext context, CategoryType category, Widget? _) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 215),
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          return DropdownButton(
                            style: const TextStyle(color: Colors.white),
                            hint: const Text(
                              'Select Category',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 77, 74, 74)),
                            ),
                            value: newselected,
                            items: state.categories
                                .where((element) =>
                                    element.type == selectedvalue.value)
                                .map((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(
                                        e.name,
                                        style:
                                            const TextStyle(color: Colors.teal),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (selectedindex) {
                              setState(() {
                                newselected = selectedindex;
                              });
                            },
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(right: 285),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.teal)),
                    onPressed: () {
                      if (purposecontroller.text.isEmpty ||
                          amountcontroller.text.isEmpty ||
                          newselected == null ||
                          _selectedDate == null) {
                        return;
                      } else {
                        log('Transaction Created');
                        BlocProvider.of<TransactioncreateCubit>(context)
                            .createTransaction(
                                TransactionModel(
                                  amount: double.parse(amountcontroller.text),
                                  category: newselected!,
                                  date: _selectedDate!,
                                  purpose: purposecontroller.text,
                                  type:
                                      selectedvalue.value == CategoryType.income
                                          ? 'income'
                                          : 'expense',
                                ),
                                TokenManager().aid!);
                      }
                    },
                    child: const Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Radiobutton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const Radiobutton({required this.title, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedvalue,
        builder: (BuildContext context, CategoryType category, Widget? _) {
          return Row(
            children: [
              Radio<CategoryType>(
                  value: type,
                  groupValue: category,
                  fillColor: WidgetStateProperty.all(Colors.teal),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedvalue.value = value;
                      newselected = null;
                    }
                  }),
              Text(title, style: const TextStyle(color: Colors.white))
            ],
          );
        });
  }
}
