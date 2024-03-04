import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  List<String> langs = ["English", "عربى"];
  List<String> Themes = ["Light", "Dark"];
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          width: mediaQuery.width,
          height: mediaQuery.height * 0.2,
          color: Color(0xFF5D9CEC),
          child: Text(
            "Settings",
            style: theme.textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(35),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              local.language,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
              items: langs,
              decoration: CustomDropdownDecoration(
                closedFillColor:
                    vm.isDark() ? Color(0xFF141922) : Color(0xFFFFFFFF),
                expandedFillColor:
                    vm.isDark() ? Color(0xFF141922) : Color(0xFFFFFFFF),
              ),
              initialItem: vm.currentLanguage == "en" ? "English" : "عربى",
              onChanged: (value) {
                if (value == "English") {
                  vm.changeLanguage("en");
                } else if (value == "عربى") {
                  vm.changeLanguage("ar");
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              local.theme,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDropdown(
              items: Themes,
              initialItem: vm.isDark() ? "Dark" : "Light",
              decoration: CustomDropdownDecoration(
                closedFillColor:
                    vm.isDark() ? Color(0xFF141922) : Color(0xFFFFFFFF),
                expandedFillColor:
                    vm.isDark() ? Color(0xFF141922) : Color(0xFFFFFFFF),
              ),
              onChanged: (value) {
                if (value == "Light") {
                  vm.changeThemeMode(ThemeMode.light);
                } else if (value == "Dark") {
                  vm.changeThemeMode(ThemeMode.dark);
                }
              },
            )
          ]),
        )
      ],
    );
  }
}
