import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/extract_data.dart';
import 'package:todo/features/tasks/widget/task_item_widget.dart';
import 'package:todo/core/utils/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/settings_provider.dart';

class TasksView extends StatefulWidget {
  TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime foucsTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Stack(
            alignment: Alignment(0, 2),
            children: [
              Container(
                color: theme.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                width: mediaQuery.width,
                height: mediaQuery.height * 0.21,
                child: Text(
                  "TODO list",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              EasyInfiniteDateTimeLine(
                showTimelineHeader: false,
                timeLineProps: EasyTimeLineProps(separatorPadding: 15),
                // controller: _controller,
                firstDate: DateTime(2023),
                focusDate: foucsTime,
                lastDate: DateTime(2025),
                dayProps: EasyDayProps(
                    height: 100,
                    inactiveDayStyle: DayStyle(
                        dayNumStyle: theme.textTheme.bodyMedium,
                        dayStrStyle: theme.textTheme.bodySmall,
                        monthStrStyle: theme.textTheme.bodySmall,
                        decoration: BoxDecoration(
                            color:
                                vm.isDark() ? Color(0xFF141922) : Colors.white,
                            borderRadius: BorderRadius.circular(10))),
                    activeDayStyle: DayStyle(
                        dayNumStyle: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.primaryColor),
                        dayStrStyle: theme.textTheme.bodySmall,
                        monthStrStyle: theme.textTheme.bodySmall,
                        decoration: BoxDecoration(
                          color: vm.isDark() ? Color(0xFF141922) : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ))),
                activeColor: Colors.white,

                onDateChange: (selectedDate) {
                  setState(() {
                    foucsTime = selectedDate;
                    vm.selectedDate = foucsTime;
                  });
                },
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseUtils()
              .getStreamDataFromFirestore(extractDateTime(vm.selectedDate)),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Column(
                children: [
                  Text("Something went wrong"),
                  Icon(Icons.refresh),
                ],
              );
            }
            ;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            ;
            var tasksList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList[index]),
                itemCount: tasksList.length,
              ),
            );
          },
        )
        // FutureBuilder<List<TaskModel>>(
        //   future: FirebaseUtils().getDataFromFirestore(extractDateTime(vm.selectedDate)),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Column(
        //         children: [
        //           Text("Somthing went wrong"),
        //           Icon(Icons.refresh),
        //         ],
        //       );
        //     }
        //     ;
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     ;
        //     var tasksList = snapshot.data ?? [];
        //     return Expanded(
        //       child: ListView.builder(
        //         padding: EdgeInsets.zero,
        //         itemBuilder: (context, index) => TaskItemWidget(taskModel: tasksList[index]),
        //         itemCount: tasksList.length,
        //       ),
        //     );
        //   },
        // )
      ],
    );
  }
}
