import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/settings/page/setting_view.dart';
import 'package:todo/features/tasks/page/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLanguage = "en";
  ThemeMode currentThemeMode = ThemeMode.dark;
  DateTime selectedDate = DateTime.now();

  selectTaskDate(BuildContext context) async{
    var currentSelectDate = await showDatePicker(context: context,
        initialDate: selectedDate,
        currentDate:DateTime.now() ,
        firstDate: selectedDate,
        lastDate: DateTime.now().add(Duration(days: 365)));

    if(currentSelectDate == null) return;

    selectedDate = currentSelectDate;
    notifyListeners();
  }

  List<Widget> screens = [TasksView(), SettingsView()];

  changeLanguage(String newLanguage) {
    if (newLanguage == currentLanguage) {
      return;
    }

    currentLanguage = newLanguage;

    notifyListeners();
  }

  int currentIndex = 0;
  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isDark() {
    return currentThemeMode == ThemeMode.dark;
  }

  changeThemeMode(ThemeMode newThemeMode) {
    print(newThemeMode);
    if (newThemeMode == currentThemeMode) return;
    currentThemeMode = newThemeMode;

    notifyListeners();
  }
}
