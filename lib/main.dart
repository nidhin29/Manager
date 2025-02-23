import 'package:telephony_fix/telephony.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:manager/Application/Accounts/Budget/budget_cubit.dart';
import 'package:manager/Application/Accounts/Create/accountscreate_cubit.dart';
import 'package:manager/Application/Accounts/Transaction/Create/transactioncreate_cubit.dart';
import 'package:manager/Application/Accounts/accounts_cubit.dart';
import 'package:manager/Application/Category/Create/create_cubit.dart';
import 'package:manager/Application/Category/category_cubit.dart';
import 'package:manager/Application/SignIn/signincubit_cubit.dart';
import 'package:manager/Core/Injectable/injectable.dart';
import 'package:manager/Domain/Accounts/Transaction/transaction_model.dart';
import 'package:manager/Presentation/Splash/splash.dart';
import 'package:manager/firebase_options.dart';



final Telephony telephony = Telephony.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureInjection(Environment.prod);
  await telephony.requestPhoneAndSmsPermissions;
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SignInCubit>(),
        ),
         BlocProvider(
          create: (context) => getIt<CategoryCubit>(),
        ),
                 BlocProvider(
          create: (context) => getIt<CreateCubit>(),
        ),
          BlocProvider(
          create: (context) => getIt<AccountsCubit>(),
        ),
          BlocProvider(
          create: (context) => getIt<AccountscreateCubit>(),
        ),
           BlocProvider(
          create: (context) => getIt<TransactioncreateCubit>(),
        ),
           BlocProvider(
          create: (context) => getIt<BudgetCubit>(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(412, 912),
        splitScreenMode: true,
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Manager',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Colors.teal,
            ),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}



TransactionModel? parseMessage(String? messageBody) {
  if (messageBody == null) return null;

  // Example SMS: "You purchased from Myntra for ₹1500 on 12/02/2025"
  // Extract amount using regex. This example looks for a currency symbol followed by digits.
  RegExp amountRegex = RegExp(r'(₹|\$)\s?(\d+(?:\.\d{1,2})?)');
  RegExpMatch? amountMatch = amountRegex.firstMatch(messageBody);
  
  if (amountMatch != null) {
    double amount = double.parse(amountMatch.group(2)!);

    // Here, you might also extract the merchant name
    // For a simple approach, assume the merchant's name follows "from ":
    String merchant = 'Online Transaction';
    RegExp merchantRegex = RegExp(r'from (\w+)', caseSensitive: false);
    RegExpMatch? merchantMatch = merchantRegex.firstMatch(messageBody);
    if (merchantMatch != null) {
      merchant = merchantMatch.group(1)!;
    }

    // You can also parse the date if needed. For now, we use the current date.
    // Example SMS: "You purchased from Myntra for ₹1500 on 12/02/2025"
    // Extract date using regex. This example looks for a date in the format dd/MM/yyyy.
    RegExp dateRegex = RegExp(r'(\d{2}/\d{2}/\d{4})');
    RegExpMatch? dateMatch = dateRegex.firstMatch(messageBody);
    
    DateTime date;
    if (dateMatch != null) {
      date = DateFormat('dd/MM/yyyy').parse(dateMatch.group(1)!);
    } else {
      date = DateTime.now();
    }
  
    return TransactionModel(
      purpose: merchant,
      amount: amount,
      date: date,
      category: 'Online Shopping',
      type: 'expense',
    );

  }

  return null;
}