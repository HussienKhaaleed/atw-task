import 'package:atw_task/Sign_in/view/widget/already_have_account_text.dart';
import 'package:atw_task/Sign_in/view/widget/app_text_form_field.dart';
import 'package:atw_task/Sign_in/view/widget/custom_toast.dart';
import 'package:atw_task/Sign_in/view/widget/text_btn.dart';
import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_cubit.dart';
import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_state.dart';
import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:atw_task/core/routers/customNavigate.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final formkey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color(0xFF475272),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Let's Register You In.",
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: const Color(0xFF475272),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Register now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xFF545D7B),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                BlocConsumer<UserAuthenticationCubit, UserAuthenticationState>(
                  listener: (context, state) {
                    if (state is SignupSucessState) {
                      customReplacementNavigate(context, "/login");
                      showToast(
                          "Account Created Successfully , Check your email to verfiy your account",
                          Colors.white);
                    } else if (state is SignupFailureState) {
                      showToast(state.errMessage, Colors.white);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formkey,
                      child: Column(
                        children: [
                          textformfield(
                            keyboardType: TextInputType.name,
                            hintText: "Username",
                            onChanged: (Username) {
                              getIt<CacheHelper>().saveData(
                                key: "Username",
                                value: Username,
                              );
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .Username = Username;
                            },
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          textformfield(
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Email",
                            onChanged: (email) {
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .emailAddress = email;
                            },
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          textformfield(
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Password",
                            onChanged: (password) {
                              BlocProvider.of<UserAuthenticationCubit>(context)
                                  .password = password;
                            },
                            isObscureText: isObscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF3E4554),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          state is SignupLoadingState
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF2A4BA0),
                                )
                              : textBtn(
                                  buttonText: "Register",
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              UserAuthenticationCubit>(context)
                                          .signUpWithEmailAndPassword();
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                          already_have_account_text(
                            onTap: () {
                              customReplacementNavigate(context, "/login");
                            },
                            fristText: 'Already have an account?',
                            secondText: ' Login',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
