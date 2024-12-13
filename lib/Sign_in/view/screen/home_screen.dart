import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:atw_task/core/routers/customNavigate.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text('Home Screen'),
            TextButton(
              onPressed: () {
                getIt<CacheHelper>().removeData(key: 'logedIn');
                FirebaseAuth.instance.signOut();
                customReplacementNavigate(context, '/login');
              },
              child: Text(
                'Sign Out',
              ),
            )
          ],
        ),
      ),
    );
  }
}
