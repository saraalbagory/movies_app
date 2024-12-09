import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/custom_elevated_button.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/custom_textfield.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/input_validation.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/support/app_images.dart';
import 'package:movies_app/support/routes_manager/routes.dart';
import 'package:movies_app/support/utils/ui_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                      child: Image.asset(
                    AppImages.logoImage,
                    width: 70.w,
                    fit: BoxFit.contain,
                  )),
                  SizedBox(
                    height: 60.h,
                  ),
                  CustomTextfield(
                    controller: emailController,
                    backgroundColor: AppColors.grayColor,
                    hint: 'Email',
                    textInputType: TextInputType.emailAddress,
                    validation: InputValidation.validateEmail,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  CustomTextfield(
                    controller: passwordController,
                    hint: 'Password',
                    backgroundColor: AppColors.grayColor,
                    validation: InputValidation.validatePassword,
                    isObscured: true,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forget password?',
                            style: TextStyle(color: AppColors.yellowColor)
                                .copyWith(fontSize: 12.sp),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Center(
                    child: SizedBox(
                      // width: MediaQuery.of(context).size.width * .8,
                      child: BlocListener<AuthCubit, AuthState>(
                        listener: (BuildContext context, state) {
                          if (state is Authenticated) {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.homeRoute);
                          }
                          if (state is AuthLoading) {
                            UIUtils.showLoadingDialog(context);
                          } else if (state is Authenticated) {
                            UIUtils.hideDialog(context);
                            Navigator.pushReplacementNamed(
                                context, Routes.homeRoute);
                          } else if (state is AuthError) {
                            UIUtils.hideDialog(context);
                            UIUtils.showErrorDialog(context, state.message);
                          }
                        },
                        child: CustomElevatedButton(
                          isStadiumBorder: false,
                          label: 'Login',
                          backgroundColor: AppColors.yellowColor,
                          textStyle: TextStyle(
                              color: AppColors.blackColor, fontSize: 16.sp),
                          onTap: () {
                            if (_key.currentState?.validate() == true) {
                              BlocProvider.of<AuthCubit>(context).login(
                                  LoginParameters(
                                      email: emailController.text,
                                      password: passwordController.text));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account?',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 12.sp,
                          )),
                      SizedBox(
                        width: 8.w,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes.signUpRoute),
                        child: Text('Create One',
                            style: TextStyle(
                                color: AppColors.yellowColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
