import 'package:atw_task/Sign_in/view/widget/already_have_account_text.dart';
import 'package:atw_task/Sign_in/view/widget/app_text_form_field.dart';
import 'package:atw_task/Sign_in/view/widget/custom_toast.dart';
import 'package:atw_task/Sign_in/view/widget/text_btn.dart';
import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_cubit.dart';
import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_state.dart';
import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:atw_task/core/routers/customNavigate.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final formkey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color(0xFF475272),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  "Let's Sign You In.",
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
                  "Welcome back.\nYou've been missed!",
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xFF545D7B),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                BlocConsumer<UserAuthenticationCubit, UserAuthenticationState>(
                  listener: (context, state) {
                    if (state is SignInSucessState) {
                      FirebaseAuth.instance.currentUser!.emailVerified
                          ? customReplacementNavigate(context, "/home")
                          : showToast(
                              "Please Verify Your Account", Colors.white);
                      ;
                    } else if (state is SignInFailureState) {
                      showToast(state.errMessage, Colors.white);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: formkey,
                      child: Column(
                        children: [
                          textformfield(
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Your Email",
                            onChanged: (email) {
                              getIt<CacheHelper>().saveData(
                                key: "Email",
                                value: email,
                              );
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
                                    : Icons.visibility_outlined,
                                color: Color(0xFF3E4554),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                          state is SignInLoadingState
                              ? const CircularProgressIndicator(
                                  color: Color(0xFFB19BF1),
                                )
                              : textBtn(
                                  buttonText: "Sign In",
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              UserAuthenticationCubit>(context)
                                          .signInWithEmailAndPassword();
                                      getIt<CacheHelper>().saveData(
                                        key: "logedIn",
                                        value: true,
                                      );
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 16.h,
                          ),
                          already_have_account_text(
                            onTap: () {
                              customNavigate(context, "/register");
                            },
                            fristText: 'Don’t have an account?',
                            secondText: ' Register',
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
