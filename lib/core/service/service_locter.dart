import 'package:atw_task/Sign_in/view_model/cubit/user_authentication_cubit.dart';
import 'package:atw_task/core/helper/cashe_helper.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setupServiceLocter() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<UserAuthenticationCubit>(UserAuthenticationCubit());
}
