import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/services/snacker_bar_service.dart';
import 'package:todo/core/utils/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/settings_provider.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFFFE4A49),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.28,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                //EasyLoading.show();
                FirebaseUtils().deleteTask(taskModel).then((value) => (value) {
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage(
                          "Task deleted successfully");
                    });
              },
              backgroundColor: Color(0xFFFE4A49),
              borderRadius: BorderRadius.circular(10),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        child: Container(
          width: mediaQuery.width,
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: vm.isDark() ? Color(0xFF141922) : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            Container(
              width: 6,
              height: 100,
              decoration: BoxDecoration(
                color:
                    taskModel.isDone ? Color(0xFF61E757) : theme.primaryColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    taskModel.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: taskModel.isDone
                          ? Color(0xFF61E757)
                          : theme.primaryColor,
                    ),
                  ),
                  Text(
                    taskModel.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: vm.isDark() ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 18,
                        color: vm.isDark() ? Colors.white : Colors.black,
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Text(DateFormat.yMMMMd().format(taskModel.date),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                vm.isDark() ? Colors.white : Color(0xFF141922),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            if(taskModel.isDone)
              Text("Done!",
              style: theme.textTheme.titleLarge?.copyWith(
                color:Color(0xFF61E757)
              ),),
            if(!taskModel.isDone)
            InkWell(
              onTap: () {
                EasyLoading.show();
                var data = TaskModel(
                    id: taskModel.id,
                    title: taskModel.title,
                    description: taskModel.description,
                    isDone: true,
                    date: taskModel.date);
                EasyLoading.dismiss();
                FirebaseUtils().updateTask(data).then((value) => (value) {
                  EasyLoading.dismiss();
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.check_rounded,
                    size: 35,
                    color: Colors.white,
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
