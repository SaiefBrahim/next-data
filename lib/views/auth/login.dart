import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:next_data_saief_brahim/controllers/auth_controller.dart';
import 'package:next_data_saief_brahim/helpers/app_theme.dart';
import 'package:next_data_saief_brahim/helpers/images.dart';
import 'package:next_data_saief_brahim/views/auth/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthController controller;
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<AuthController>()) {
      controller = Get.find<AuthController>();
    } else {
      controller = Get.put(AuthController());
    }
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
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
                    EdgeInsets.only(top: 120, right: 20, bottom: 20, left: 20),
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
                    const Text("Login with email",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey)),
                    const SizedBox(height: 40),
                    loginForm(),
                    const SizedBox(height: 10),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: const Text("Forget Password",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.primary)),
                    ),
                    const SizedBox(height: 25),
                    loginButton(),
                    const SizedBox(height: 20),
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
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          hintText: "Email",
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
      controller: controller.loginEmailController,
      validator: controller.validateEmail,
    );
  }

  Widget passwordField() {
    return Obx(
      () => TextFormField(
        keyboardType: TextInputType.text,
        obscureText: controller.showPassword.value ? false : true,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: "Password",
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
        controller: controller.loginPasswordController,
        validator: controller.validatePassword,
      ),
    );
  }

  Widget loginButton() {
    return Obx(
      () => Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(Get.context!);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              if (!controller.loginLoading.value) {
                controller.signInWithEmailAndPassword();
              }
            },
            style: const ButtonStyle(
                padding:
                    WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
                backgroundColor: WidgetStatePropertyAll(AppTheme.primary),
                elevation: WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))))),
            child: controller.loginLoading.value
                ? const SizedBox(
                    height: 22.0,
                    width: 22.0,
                    child: CircularProgressIndicator(color: AppTheme.onPrimary),
                  )
                : const Text(
                    "Sign In",
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

  Widget registerBtn() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const SignUpScreen(), transition: Transition.fadeIn);
            },
            style: const ButtonStyle(
                padding:
                    WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
                backgroundColor: WidgetStatePropertyAll(AppTheme.light),
                elevation: WidgetStatePropertyAll(0),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    side: BorderSide(color: AppTheme.primary)))),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppTheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
