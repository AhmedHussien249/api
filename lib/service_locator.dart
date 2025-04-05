import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/cart/bloc.dart';
import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/components/products/cubit.dart';
import 'package:api/themar_screens/components/slider/cubit.dart';
import 'package:api/themar_screens/contuct_us/bloc.dart';
import 'package:api/themar_screens/login/cubit.dart';
import 'package:api/themar_screens/terms/cubit.dart';
import 'package:api/themar_screens/update_cart_item/bloc.dart';
import 'package:get_it/get_it.dart';

import 'counter/cubit.dart';

void initServiceLocator() {
  final container = GetIt.instance;
  container.registerSingleton(DioHelper());
  container.registerFactory(() => CounterCubit());
  container.registerFactory(() => LoginCubit(GetIt.instance<DioHelper>()));
  container.registerFactory(() => ContactUsBloc(GetIt.instance<DioHelper>()));
  container
      .registerFactory(() => UpdateCartItemBloc(GetIt.instance<DioHelper>()));
  container.registerFactory(
      () => CartBloc(GetIt.instance<DioHelper>())..add(GetCartEvent()));
  container.registerFactory(
      () => CategoriesCubit(GetIt.instance<DioHelper>())..getData());
  container.registerFactory(
      () => ProductsCubit(GetIt.instance<DioHelper>())..getData());
  container.registerFactory(
      () => SliderCubit(GetIt.instance<DioHelper>())..getData());
  container.registerFactory(
      () => TermsCubit(GetIt.instance<DioHelper>())..getData());
}
