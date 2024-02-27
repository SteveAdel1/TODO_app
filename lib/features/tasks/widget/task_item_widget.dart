import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/settings_provider.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);
    var theme = Theme.of(context);
    return Container(
      width: mediaQuery.width,
      height: 115,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: vm.isDark()?Color(0xFF141922):Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Container(
          width: 6,
          height: 90,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(width: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Go to GYM",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(height: 6,),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  size: 20,color: vm.isDark() ? Colors.white : Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("10:00am",
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
        Spacer(),
        Container(
            padding:  EdgeInsets.symmetric(horizontal: 25),
            decoration:BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(10)
        ),
          child:Icon(Icons.check_rounded,size:35,color: Colors.white,))
      ]),
    );
  }
}
