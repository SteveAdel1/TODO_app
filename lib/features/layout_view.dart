import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/settings_provider.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "LayoutView";
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      body: vm.screens[vm.currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 33,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            currentIndex: vm.currentIndex,
            onTap: vm.changeIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]),
      ),
    );
  }
}
