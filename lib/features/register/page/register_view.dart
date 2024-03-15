import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/login/page/login_view.dart';
import 'package:todo/firebase_utils.dart';

import '../../../core/widgets/custom_text_form_feild.dart';
import '../../../settings_provider.dart';

class RegisterView extends StatefulWidget {
  var  formKey = GlobalKey<FormState>();
  static const String routeName = "registerview";
  var passwordController =TextEditingController();
  var fullNameController =TextEditingController();
  var emailController =TextEditingController();
  var confirmPasswordController =TextEditingController();
   RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;

    FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    return
      Container(
        decoration: BoxDecoration(
            color: vm.isDark() ? Color(0xFF141922) : Color(0xFFDFECDB),
            image:const DecorationImage(
                image: AssetImage(
                  "assets/images/auth_pattern.png",
                ),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Create Account",
              style: theme.textTheme.titleLarge,
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                key: widget.formKey,
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
                      /////////////////////////////////////////////////////////////////////////
                      //enter the name section
                      Text(
                        "Full name",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        onValidate: (value) {
                          if(value == null || value.trim().isEmpty){
                            return " you must enter your name " ;
                          }
                          return null ;
                        },
                        controller: widget.fullNameController,
                        hint: "enter your name",
                        InputDecoration(),
                        suffixWidget: Icon(
                          Icons.person,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ////////////////////////////////////////////////////////////////////////
                      // enter the email section
                      Text(
                        "E-mail",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
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
                        controller: widget.emailController,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        keyboardType: TextInputType.emailAddress,
                        hint: "enter your E-mail",
                        InputDecoration(),
                        suffixWidget: Icon(
                          Icons.mail_rounded,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ////////////////////////////////////////////////////////////////////////
                      // enter the password section
                      Text(
                        "Password",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
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
                        controller: widget.passwordController,
                        isPassword: true,
                        maxLines: 1,
                        hint: "enter your password",
                        InputDecoration(),
                        suffixWidget: Icon(
                          Icons.remove_red_eye_rounded,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ////////////////////////////////////////////////////////////////////////
                      // confirming password section
                      Text(
                        "Confirm your password",
                        style: theme.textTheme.bodyMedium,
                      ),
                      CustomTextField(
                        //controller: confirmPasswordController,
                        onValidate: (value) {
                          if(value ==null || value.trim().isEmpty){
                            return "you must confirm your password";
                          }
                          if(value != widget.passwordController.text){
                            return "password is not matched";
                          }
                          return null ;
                        },
                        isPassword: true,
                        maxLines: 1,
                        hint: "enter your password",
                        InputDecoration(),
                        suffixWidget: Icon(
                          Icons.remove_red_eye_rounded,
                          color: vm.isDark() ? Colors.white : Colors.black,
                        ),
                      ),
                     const SizedBox(
                        height: 40,
                      ),
                      //////////////////////////////////////////////////////////
                      //sign up button
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 50)),
                          onPressed: () {
                            if(widget.formKey.currentState!.validate()){
                              FirebaseUtils().createUserWithEmailAndPassword(
                                  widget.emailController.text,
                                  widget.passwordController.text).then((value) => (value) {
                                    if(value){
                                      EasyLoading.dismiss();
                                      Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);
                                    }
                                  });

                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create new account ",
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
                    ]),
              ),
            ),
          ),
        ),
      );
  }
}
