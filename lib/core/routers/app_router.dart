import 'package:atw_task/Sign_in/view/screen/Loding_Screen.dart';
import 'package:atw_task/Sign_in/view/screen/home_screen.dart';
import 'package:atw_task/Sign_in/view/screen/login_screen.dart';
import 'package:atw_task/Sign_in/view/screen/register_screen.dart';
import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_cubit.dart';
import 'package:atw_task/core/service/service_locter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, State) => LodingScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<UserAuthenticationCubit>(),
          child: const loginScreen(),
        ),
      ),
      GoRoute(
        path: "/register",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<UserAuthenticationCubit>(),
          child: const registerScreen(),
        ),
      ),
      GoRoute(
        path: "/home",
        builder: (context, State) => HomeScreen(),
      ),
    ],
  );
}
