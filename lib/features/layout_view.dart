import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/settings_provider.dart';

class LayoutView extends StatefulWidget {
  static const String routeName = "LayoutView";
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      body: vm.screens[vm.currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.white),
            borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          FirebaseUtils().addANewTask();
        },
        child:const Icon(
          Icons.add,
          size: 33,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape:const CircularNotchedRectangle(),
        child: BottomNavigationBar(
            currentIndex: vm.currentIndex,
            onTap: vm.changeIndex,
            items: const [
               BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
               BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]),
      ),
    );
  }
}
