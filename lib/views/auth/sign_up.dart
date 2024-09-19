import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/controllers/auth_controller.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<AuthController>()) {
      controller = Get.find<AuthController>();
    } else {
      controller = Get.put(AuthController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppTheme.light,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 120, right: 20, bottom: 20, left: 20),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppImages.logo,
                      height: 90,
                    ),
                    const SizedBox(height: 40),
                    const Text("Welcome to Next Data",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22)),
                    const SizedBox(height: 10),
                    const Text("Create an account to get started",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey)),
                    const SizedBox(height: 40),
                    loginForm(),
                    const SizedBox(height: 25),
                    registerBtn(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget loginForm() {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 5),
          nameField(),
          const SizedBox(height: 20),
          const Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 5),
          emailField(),
          const SizedBox(height: 20),
          const Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
          const SizedBox(height: 5),
          passwordField(),
          const SizedBox(height: 10),
          confirmPasswordField(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "email@email.com",
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          isCollapsed: true),
      cursorColor: AppTheme.base,
      maxLines: 1,
      controller: controller.signUpEmailController,
      validator: controller.validateEmail,
    );
  }

  Widget nameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: "Name",
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.base, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(6))),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          isCollapsed: true),
      cursorColor: AppTheme.base,
      maxLines: 1,
      controller: controller.signUpNameController,
      validator: controller.validateEmail,
    );
  }

  Widget passwordField() {
    return Obx(()=>
      TextFormField(
        keyboardType: TextInputType.text,
        obscureText: controller.showPassword.value ? false : true,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: "Create password",
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            suffixIcon: InkWell(
                onTap: () {
                  controller.onChangeShowPassword();
                },
                child: Icon(controller.showPassword.value
                    ? Icons.visibility_off
                    : Icons.visibility)),
            contentPadding: const EdgeInsets.all(16),
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
            isCollapsed: true),
        cursorColor: AppTheme.base,
        maxLines: 1,
        controller: controller.signUpPasswordController,
        validator: controller.validatePassword,
      ),
    );
  }

  Widget confirmPasswordField() {
    return Obx(()=>
       TextFormField(
        keyboardType: TextInputType.text,
        obscureText: controller.showPassword.value ? false : true,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: "Create password",
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.base, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            suffixIcon: InkWell(
                onTap: () {
                  controller.onChangeShowPassword();
                },
                child: Icon(controller.showPassword.value
                    ? Icons.visibility_off
                    : Icons.visibility)),
            contentPadding: const EdgeInsets.all(16),
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
            isCollapsed: true),
        cursorColor: AppTheme.base,
        maxLines: 1,
        controller: controller.signUpConfirmPasswordController,
        validator: controller.validateConfirmPassword,
      ),
    );
  }

  Widget registerBtn() {
    return Obx(()=>
       Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              FocusScopeNode currentFocus =
              FocusScope.of(Get.context!);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              if (!controller.signUpLoading.value) {
                controller.signUp();
              }
            },
            style: const ButtonStyle(
                padding:
                    WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
                backgroundColor: WidgetStatePropertyAll(AppTheme.primary),
                elevation: WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))))),
            child: controller.signUpLoading.value
                ? const SizedBox(
                    height: 22.0,
                    width: 22.0,
                    child: CircularProgressIndicator(color: AppTheme.onPrimary),
                  )
                : const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppTheme.onPrimary),
                  ),
          )),
        ],
      ),
    );
  }
}
