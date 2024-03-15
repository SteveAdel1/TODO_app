import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/layout_view.dart';
import 'package:todo/features/register/page/register_view.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/settings_provider.dart';
import '../../../core/widgets/custom_text_form_feild.dart';

class LoginView extends StatefulWidget {
  static const String routeName = "LoginView";
  var emailController =TextEditingController();
  var passwordController =TextEditingController();

   LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: vm.isDark() ? Color(0xFF141922) : Color(0xFFDFECDB),
          image:const DecorationImage(
              image: AssetImage(
                "assets/images/auth_pattern.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: theme.textTheme.titleLarge,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: mediaQuery.height * 0.17,
                    ),
                    Text(
                      "Welcome Back!",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ////////////////////////////////////////////////////////////////////
                    //enter emil section
                    Text(
                      "E-mail",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      controller: widget.emailController,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter E-mail";
                        }

                        var regex = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                        if (!regex.hasMatch(value)) {
                          return "invalid Email";
                        }

                        return null;
                      },

                      keyboardType: TextInputType.emailAddress,
                      hint: "enter your E-mail",
                    const  InputDecoration(),
                      suffixWidget: Icon(
                        Icons.mail_rounded,
                        color: vm.isDark() ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ///////////////////////////////////////////////////////////////////
                    //enter password section
                    Text(
                      "Password",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      controller: widget.passwordController,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "enter password";
                        }

                        var regex = RegExp(
                            r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                        if (!regex.hasMatch(value)) {
                          return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 6 characters long.";
                        }

                        return null;
                      },
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      isPassword: true,
                      maxLines: 1,
                      hint: "enter your password",
                     const InputDecoration(),
                      suffixWidget: Icon(
                        Icons.remove_red_eye_rounded,
                        color: vm.isDark() ? Colors.white : Colors.white,
                      ),
                    ),
                   const SizedBox(
                      height: 40,
                    ),
                    /////////////////////////////////////////////////////////////
                    //login button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 50)),
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            FirebaseUtils().loginUserAccount(
                              widget.emailController.text,
                              widget.passwordController.text
                            ).then((value){
                              if(value==true){
                                EasyLoading.dismiss();
                                Navigator.pushReplacementNamed(context, LayoutView.routeName);
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Login",
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                           const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            )
                          ],
                        )),
                    //////////////////////////////////////////////////////////////
                    //create new account section
                    Text(
                      "OR",
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.routeName);
                        },
                        child: Text("Create new account..!",
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center)),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
