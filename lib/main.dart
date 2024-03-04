import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/login/page/login_view.dart';
import 'package:todo/features/register/page/register_view.dart';
import 'package:todo/features/spalsh/page/splash_view.dart';
import 'package:todo/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/config/Application_theme_manager.dart';
import 'features/layout_view.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: vm.currentThemeMode,
      debugShowCheckedModeBanner: false,
      theme: ApplicationThemeManager.lighttheme,
      darkTheme: ApplicationThemeManager.darktheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale(vm.currentLanguage),
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LayoutView.routeName: (context) => const LayoutView(),
        LoginView.routeName: (context) =>  LoginView(),
        RegisterView.routeName: (context) =>  RegisterView(),
      },
    );
  }
}
