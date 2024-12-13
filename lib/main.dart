import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:atw_task/core/routers/app_router.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:atw_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getIt<CacheHelper>().init();
  runApp(const Atw());
}

class Atw extends StatefulWidget {
  const Atw({super.key});

  @override
  State<Atw> createState() => _AtwState();
}

class _AtwState extends State<Atw> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
        );
      },
    );
  }
}
