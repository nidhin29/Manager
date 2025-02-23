

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:manager/Presentation/constants/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageWithTextFields extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingPageWithTextFields({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 200.h),
          kheight20,
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          kheight10,
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white70,
            ),
          ),
          kheight20,
           IntrinsicWidth(
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: '₹ 0',
                hintStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) async{
                final prefs = await SharedPreferences.getInstance();
                     await prefs.setInt('rupees', int.parse(value));
              },
            ),
          ),
          kheight20,
          ValueListenableBuilder<String>(
            valueListenable: selectedFrequency,
            builder: (context, value, child) {
              return DropdownButton<String>(
                value: value,
                dropdownColor: Colors.black,
                icon: const SizedBox(),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 2,
                  color: Colors.teal,
                ),
                onChanged: (String? newValue) async{
                  selectedFrequency.value = newValue!;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('frequency', selectedFrequency.value);
                },
                items: <String>['Daily', 'Weekly', 'Monthly', 'Yearly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            },
          ),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('beginning', style: TextStyle(color: Colors.white)),
              kwidth10,
              GestureDetector(
                onTap: () => selectDate(context),
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: selectedDate,
                  builder: (context, value, child) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
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
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 10),
          const Text(
            'You can always edit this later.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
