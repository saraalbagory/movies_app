import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/custom_elevated_button.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/custom_textfield.dart';
import 'package:movies_app/features/authentication/presentation/view/widgets/input_validation.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/support/app_images.dart';
import 'package:movies_app/support/routes_manager/routes.dart';
import 'package:movies_app/support/utils/ui_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    nameController.dispose();
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
              child: BlocListener<AuthCubit, AuthState>(
                listener: (BuildContext context, state) {
                  if (state is Authenticated) {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute);
                  }
                  if (state is AuthLoading) {
                    UIUtils.showLoadingDialog(context);
                  } else if (state is Authenticated) {
                    UIUtils.hideDialog(context);
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  } else if (state is AuthError) {
                    UIUtils.hideDialog(context);
                    UIUtils.showErrorDialog(context, state.message);
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(child: Image.asset(AppImages.gamer1Image)),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextfield(
                      controller: nameController,
                      backgroundColor: AppColors.grayColor,
                      hint: 'Name',
                      textInputType: TextInputType.name,
                      validation: InputValidation.validateFullName,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    CustomTextfield(
                      controller: emailController,
                      hint: 'Email',
                      backgroundColor: AppColors.grayColor,
                      validation: InputValidation.validateEmail,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 18.h,
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
                      height: 18.h,
                    ),
                    CustomTextfield(
                      controller: confirmController,
                      hint: 'Confirm Password',
                      backgroundColor: AppColors.grayColor,
                      // validation: InputValidation.validateConfirmPassword,
                      isObscured: true,
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    CustomTextfield(
                      controller: mobileController,
                      hint: 'Phone Number',
                      backgroundColor: AppColors.grayColor,
                      validation: InputValidation.validatePhoneNumber,
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Center(
                      child: SizedBox(
                        height: 60.h,
                        width: MediaQuery.of(context).size.width * .9,
                        child: CustomElevatedButton(
                          isStadiumBorder: false,
                          label: 'Create Account',
                          backgroundColor: AppColors.yellowColor,
                          textStyle: TextStyle(
                              color: AppColors.blackColor, fontSize: 16.sp),
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context).register(
                                  RegisterParameters(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: mobileController.text,
                                      confirmPassword: passwordController.text,
                                      name: nameController.text));
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          style: TextStyle(color: AppColors.whiteColor)
                              .copyWith(fontSize: 12.sp),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, Routes.loginRoute),
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: AppColors.yellowColor)
                                .copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
