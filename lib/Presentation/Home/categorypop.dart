// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager/Application/Category/Create/create_cubit.dart';
import 'package:manager/Application/Category/category_cubit.dart';
import 'package:manager/Domain/Accounts/Category/category_model.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<CategoryType> selectedindex = ValueNotifier(CategoryType.income);

class CategoryPopUp extends StatelessWidget {
  CategoryPopUp({super.key});
  final textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocConsumer<CreateCubit, CreateState>(
            listener: (context, state) {
              state.failureOrSuccessOption.fold(
                  () => {},
                  (either) => either.fold(
                      (failure) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(failure.toString())))
                          },
                      (a) => {
                           BlocProvider.of<CategoryCubit>(context).getCategories(),
                           Navigator.of(context).pop()
                      
                      }));
            },
            builder: (context, state) {
              if(state.isLoading){
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 13, right: 13, top: 12),
                    child: TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: textcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Purpose',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                        )),
                  ),
                  const Row(children: [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expense', type: CategoryType.expense)
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 285),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.teal)),
                        onPressed: () {
                          final name = textcontroller.text;
                          if (name.isEmpty) {
                            return;
                          } else {
                            BlocProvider.of<CreateCubit>(context)
                                .createCategory(CategoryModel(id:generateUniqueId() , name: name, type: selectedindex.value));
                          }
                        },
                        child: const Text('Submit')),
                  )
                ],
              );
            },
          )),
    );
  }
}

String generateUniqueId() {
  const uuid = Uuid();
  return uuid.v4();
}


class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedindex,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newCategory,
                  fillColor: WidgetStateProperty.all(Colors.teal),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      selectedindex.value = value;
                      // ignore: invalid_use_of_protected_member
                      selectedindex.notifyListeners();
                    }
                  });
            }),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
