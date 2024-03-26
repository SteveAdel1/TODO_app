import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/config/constants.dart';
import 'package:todo/core/services/snacker_bar_service.dart';
import 'package:todo/core/utils/extract_data.dart';
import 'package:todo/core/widgets/custom_text_form_feild.dart';
import 'package:todo/core/utils/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/settings_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: mediaQuery.width,
        decoration: BoxDecoration(
            borderRadius:const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: vm.isDark() ? Color(0xFF141922) : Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, right: 10, left: 10, bottom: 30),
                    child: Text(
                      "Add new task",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: vm.isDark() ? Colors.white : Colors.black),
                    ),
                  ),
                  CustomTextField(
                    controller: titleController,
                    maxLines: 1,
                    hint: "enter your task",
                    const InputDecoration(),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "your must enter task title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    hint: "enter your details",
                    maxLines: 3,
                    maxLength: 150,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "you must enter details";
                      }
                      return null;
                    },
                    const InputDecoration(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Select time",
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      vm.selectTaskDate(context);
                    },

                    child: Text(
                      DateFormat.yMMMMd().format(vm.selectedDate),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                            vm.isDark() ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed:() {
                        if (formKey.currentState!.validate()) {
                          var data = TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              isDone: false,
                              date:extractDateTime(vm.selectedDate)
                              );
                          EasyLoading.show();
                          FirebaseUtils().addANewTask(data).then((value){
                            EasyLoading.dismiss();
                            SnackBarService.showSuccessMessage("Task added successfully");
                          }).onError((error, stackTrace) {
                            EasyLoading.dismiss();
                          });
                        }
                      },
                      child: Text(
                        "Add Task",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
