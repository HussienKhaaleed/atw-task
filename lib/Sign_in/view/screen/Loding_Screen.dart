import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:atw_task/core/routers/customNavigate.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LodingScreen extends StatefulWidget {
  const LodingScreen({super.key});

  @override
  State<LodingScreen> createState() => _LodingScreenState();
}

class _LodingScreenState extends State<LodingScreen> {
  @override
  void initState() {
    bool logedIn = getIt<CacheHelper>().getData(key: "logedIn") ?? false;
    if (logedIn == true) {
      FirebaseAuth.instance.currentUser == null
          ? delayedNavigate(context, "/login")
          : FirebaseAuth.instance.currentUser!.emailVerified == true
              ? delayedNavigate(context, "/home")
              : delayedNavigate(context, "/login");
    } else {
      delayedNavigate(context, "/login");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF07A66FF),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

void delayedNavigate(context, path) {
  Future.delayed(
    const Duration(seconds: 2),
    () {
      customReplacementNavigate(context, path);
    },
  );
}
