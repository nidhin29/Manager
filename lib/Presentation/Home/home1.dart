// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:telephony_fix/telephony.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:manager/Application/Accounts/Budget/budget_cubit.dart';
import 'package:manager/Application/Accounts/Create/accountscreate_cubit.dart';
import 'package:manager/Application/Accounts/Transaction/Create/transactioncreate_cubit.dart';
import 'package:manager/Application/Accounts/accounts_cubit.dart';
import 'package:manager/Application/SignIn/signincubit_cubit.dart';
import 'package:manager/Domain/Accounts/accounts_model.dart';
import 'package:manager/Domain/Token%20Manager/token_manager.dart';
import 'package:manager/Presentation/Home/categorypop.dart';
import 'package:manager/Presentation/Home/transactionpop.dart';
import 'package:manager/Presentation/Intro/intro.dart';
import 'package:manager/Presentation/constants/const.dart';
import 'package:manager/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<HomePage> {
  bool showExpense = true;
  double maxYValue = 1000;
  String? bankName;
  String? selectedBankId;
  @override
  void initState() {
    super.initState();
    // _generateMockData();
  }

  void _showAddBankNameSheet() {
    final TextEditingController bankController = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 600.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  cursorColor: Colors.teal,
                  style: const TextStyle(color: Colors.white),
                  controller: bankController,
                  decoration: const InputDecoration(
                    labelText: 'Bank Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: () {
                    final id = "${generateUniqueId()}accounts";
                    setState(() {
                      bankName = bankController.text;
                      BlocProvider.of<AccountsCubit>(context).createAccount(
                          AccountsModel(
                              id: id, name: bankName!, transactions: []));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show bottom sheet to add budget
  void _showAddBudgetSheet() {
    final TextEditingController amountController = TextEditingController();
    ValueNotifier<String> selectedFrequency = ValueNotifier<String>('Monthly');
    ValueNotifier<DateTime> selectedDate =
        ValueNotifier<DateTime>(DateTime.now());

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Date', selectedDate.value.toString());
      }
    }

    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 600.h,
          width: 300.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 2.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('Amount', int.parse(value));
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ValueListenableBuilder<String>(
                        valueListenable: selectedFrequency,
                        builder: (context, value, child) {
                          return DropdownButton<String>(
                            value: value,
                            dropdownColor: Colors.grey[900],
                            items: ['Daily', 'Weekly', 'Monthly', 'Yearly']
                                .map((String frequency) {
                              return DropdownMenuItem<String>(
                                value: frequency,
                                child: Text(
                                  frequency,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              selectedFrequency.value = newValue!;
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'Frequency', selectedFrequency.value);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () => selectDate(context),
                        child: ValueListenableBuilder<DateTime>(
                          valueListenable: selectedDate,
                          builder: (context, value, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 16.w),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.teal,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                DateFormat('MMMM d').format(value),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<BudgetCubit>(context).getBudget();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBudgetWidget(BudgetModel bankBudget, int total) {
    if (bankBudget.amount == -1 || bankBudget.frequency.isEmpty) {
      // Show Add button if no bank data is entered
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: GestureDetector(
          onTap: _showAddBudgetSheet, // Trigger first bottom sheet
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.teal, size: 30.sp),
                  SizedBox(height: 8.h),
                  Text('Add Budget',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // Show the budget content after entering data
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: Text('Budget',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    kwidth15,
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<BudgetCubit>(context).deleteBudget();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              kheight10,
              Padding(
                padding: EdgeInsets.only(left: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: bankBudget.amount - total <= 0
                      ? [
                          Text('You cannot spend any more',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold)),
                        ]
                      : [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  '₹${(bankBudget.amount - total).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                              Text('left of',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                              Text('₹${(bankBudget.amount).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                            'for ${bankBudget.frequency == 'Daily' ? '1 day' : bankBudget.frequency == 'Weekly' ? '7 days' : bankBudget.frequency == 'Monthly' ? '30 days' : '365 days'}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  double predictNextMonthExpense(List<FlSpot> expenseData) {
    if (expenseData.isEmpty) return 0.0;

    // Calculate the total expense for the current month
    double totalExpense = expenseData.fold(
        0, (previousValue, element) => previousValue + element.y);

    // Calculate the average daily expense
    int daysInCurrentMonth = DateTime.now().day;
    double averageDailyExpense = totalExpense / daysInCurrentMonth;

    // Get the number of days in the next month
    DateTime now = DateTime.now();
    int daysInNextMonth = DateTime(now.year, now.month + 1, 0).day;

    // Predict the total expense for the next month
    return averageDailyExpense * daysInNextMonth;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AccountscreateCubit>(context).getAccounts();
      BlocProvider.of<BudgetCubit>(context).getBudget();
      // final accountsCubit = BlocProvider.of<AccountscreateCubit>(context);
      if (selectedBankId == null) {
        setState(() {
          selectedBankId = TokenManager().aid;
        });
      }
      final Telephony telephony = Telephony.instance;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        telephony.listenIncomingSms(
          listenInBackground: false,
          onNewMessage: (SmsMessage message) {
            final transaction = parseMessage(message.body);
            if (transaction != null) {
              BlocProvider.of<TransactioncreateCubit>(context)
                  .createTransaction(transaction, selectedBankId!);
            }
          },
        );
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TransactionPopUp()));
        },
        backgroundColor: Colors.teal,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocConsumer<SignInCubit, SignInCubitState>(
        listener: (context, state) {
          state.isSignedIn
              ? const ScaffoldMessenger(child: Text('Sign Out Failed'))
              : Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const IntroPage()));
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight10,
                kheight20,
                kheight20,
                kheight20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello there',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(TokenManager().name ?? '',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<SignInCubit>(context).signOut();
                        },
                        icon: const Icon(Icons.logout),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                kheight20,
                kheight20,
                SizedBox(
                  height: 150.h,
                  child: BlocListener<AccountsCubit, AccountsState>(
                    listener: (context, state) {
                      state.failureOrSuccessOption.fold(() {}, (either) {
                        either.fold((l) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l.toString())));
                        }, (r) {
                          // BlocProvider.of<AccountscreateCubit>(context)
                          //     .getAccounts();
                        });
                      });
                    },
                    child:
                        BlocBuilder<AccountscreateCubit, AccountscreateState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return state.failureOrSuccessOption.fold(
                          () => Center(
                            child: Text(
                              'No Data',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                          ),
                          (a) => a.fold(
                              (l) => Center(
                                    child: Text(
                                      'No Data',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.sp),
                                    ),
                                  ),
                              (r) => r.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No Data',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp),
                                      ),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, index) {
                                        if (index == r.length) {
                                          // Add button at the end
                                          return _buildAddBankButton(
                                              context, _showAddBankNameSheet);
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedBankId = r[index].id;
                                            });
                                            TokenManager().setAid(r[index].id);
                                          },
                                          child: _buildBankCard(
                                              r[index].name,
                                              r[index].transactions.length,
                                              selectedBankId == r[index].id),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return kwidth10;
                                      },
                                      itemCount:
                                          r.length + 1, // Includes the button
                                      scrollDirection: Axis.horizontal,
                                    )),
                        );
                      },
                    ),
                  ),
                ),
                kheight20,
                kheight20,
                BlocBuilder<BudgetCubit, BudgetState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return state.failureOrSuccessOption.fold(
                      () => Container(),
                      (budget) => _buildBudgetWidget(budget, state.total),
                    );
                  },
                ),
                kheight20,
                kheight20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: BlocBuilder<AccountscreateCubit, AccountscreateState>(
                    builder: (context, state) {
                      state.failureOrSuccessOption.fold(() {}, (either) {
                        either.fold((l) {}, (r) {});
                      });
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return state.failureOrSuccessOption.fold(
                          () => Container(),
                          (either) => either.fold(
                              (l) => Container(),
                              (r) => r.isEmpty
                                  ? Container()
                                  : r
                                          .firstWhere(
                                            (element) =>
                                                element.id == selectedBankId,
                                            orElse: () => AccountsModel(
                                                id: '',
                                                name: '',
                                                transactions: []),
                                          )
                                          .transactions
                                          .isEmpty
                                      ? Container()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: LineChart(mainData(
                                                  showExpense: showExpense,
                                                  getGraphData(
                                                          r, selectedBankId)[
                                                      'maxYValue'],
                                                  expenseData: getGraphData(
                                                          r, selectedBankId)[
                                                      'expenseData'],
                                                  incomeData: getGraphData(
                                                          r, selectedBankId)[
                                                      'incomeData'])),
                                            ),
                                            kheight10,
                                            kheight20,
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: ToggleButtons(
                                                isSelected: [
                                                  showExpense,
                                                  !showExpense
                                                ],
                                                onPressed: (index) {
                                                  setState(() {
                                                    showExpense = index == 0;
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                selectedColor: Colors.white,
                                                fillColor: Colors.teal,
                                                color: Colors.grey,
                                                children: const [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: Text('Expense'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16),
                                                    child: Text('Income'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            kheight10,
                                            kheight20,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(15.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[900],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50.h,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.teal,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                      child: Center(
                                                        child: Text(
                                                            'Predicted Expense',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                    kheight20,
                                                    Text(
                                                      '₹${predictNextMonthExpense(getGraphData(r, selectedBankId)['expenseData']).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        color: Colors.teal,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )));
                    },
                  ),
                ),
                kheight20,
              ],
            ),
          );
        },
      ),
    );
  }

  LineChartData mainData(
    double? maxYValue, {
    required List<FlSpot> expenseData,
    required List<FlSpot> incomeData,
    required bool showExpense, // ✅ Fix missing `showExpense`
  }) {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    // Define X-axis labels
    List<int> labels = [
      0,
      daysInMonth ~/ 4,
      daysInMonth ~/ 2,
      (daysInMonth * 3) ~/ 4,
      daysInMonth - 1
    ];
    Set<int> labelSet = labels.toSet();

    // ✅ Round maxYValue to the nearest 100
    double roundedMaxY = ((maxYValue ?? 1000) / 100).ceil() * 100;
    double minY = 0, maxY = roundedMaxY;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        verticalInterval: (daysInMonth / 4).toDouble(),
        horizontalInterval: (maxY / 5) == 0 ? 1 : maxY / 5,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
        getDrawingVerticalLine: (_) =>
            FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: (value, _) {
              int intValue =
                  value.round(); // ✅ Round to avoid float precision issues
              if (!labelSet.contains(intValue)) return Container();
              return Text(
                DateFormat('MMM d')
                    .format(DateTime(now.year, now.month, intValue + 1)),
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50, // Slightly increased for better spacing
            interval: ((maxY - minY) / 2.0) == 0 ? 1 : (maxY - minY) / 2.0, // Ensure proper spacing
            getTitlesWidget: (value, _) {
              // Show formatted values
              return Text(formatCurrency(value),
                  style: const TextStyle(color: Colors.white));
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: daysInMonth.toDouble() - 1,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          preventCurveOverShooting: true,
          spots: showExpense ? expenseData : incomeData,
          isCurved: true,
          gradient: LinearGradient(
            colors: showExpense
                ? [Colors.redAccent, Colors.red]
                : [Colors.greenAccent, Colors.green],
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
              radius: 4,
              color: Colors.white,
              strokeWidth: 2,
              strokeColor: showExpense ? Colors.red : Colors.green,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: showExpense
                  ? [
                      Colors.redAccent.withOpacity(0.2),
                      Colors.red.withOpacity(0.2)
                    ]
                  : [
                      Colors.greenAccent.withOpacity(0.2),
                      Colors.green.withOpacity(0.2)
                    ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildBankCard(String name, int transactions, bool isSelected) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: Container(
      width: 120.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected ? Border.all(color: Colors.teal, width: 2.0) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          Text('$transactions transactions',
              style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
        ],
      ),
    ),
  );
}

Widget _buildAddBankButton(BuildContext context, Function() onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 120.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.white, size: 30.sp),
          SizedBox(height: 8.h),
          Text('Add Bank',
              style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        ],
      ),
    ),
  );
}

Map<String, dynamic> getGraphData(
    List<AccountsModel> accounts, String? selectedBankId) {
  if (selectedBankId == null || accounts.isEmpty) {
    return {
      'expenseData': [],
      'incomeData': [],
      'maxYValue': 1000.0, // Default max value
    };
  }

  // Find selected account safely
  var selectedAccount = accounts.firstWhere(
    (element) => element.id == selectedBankId,
    orElse: () => AccountsModel(id: '', name: '', transactions: []),
  );

  // Get transactions for the current month
  List<FlSpot> expenseData = selectedAccount.transactions
      .where((transaction) =>
          transaction.date.month == DateTime.now().month &&
          transaction.type == 'expense')
      .map((e) => FlSpot(e.date.day.toDouble(), e.amount))
      .toList();

  List<FlSpot> incomeData = selectedAccount.transactions
      .where((transaction) =>
          transaction.date.month == DateTime.now().month &&
          transaction.type == 'income')
      .map((e) => FlSpot(e.date.day.toDouble(), e.amount))
      .toList();

  // Get max values safely
  double maxExpense =
      expenseData.isNotEmpty ? expenseData.map((e) => e.y).reduce(max) : 0;
  double maxIncome =
      incomeData.isNotEmpty ? incomeData.map((e) => e.y).reduce(max) : 0;
  double safeMaxYValue = max(maxExpense, maxIncome) * 1.2;

  return {
    'expenseData': expenseData,
    'incomeData': incomeData,
    'maxYValue': safeMaxYValue,
  };
}

String formatCurrency(double value) {
  if (value >= 1000) {
    return '₹${(value / 1000).toStringAsFixed(1)}K'; // Converts 8100 → 8.1K
  }
  return '₹${value.toInt()}';
}
