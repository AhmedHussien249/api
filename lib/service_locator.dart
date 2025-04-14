import 'package:api/core/logic/dio_helper.dart';

import 'package:get_it/get_it.dart';

import 'examples/counter/cubit.dart';
import 'themar_screens/features/cart/bloc.dart';
import 'themar_screens/features/category_section/cubit.dart';
import 'themar_screens/features/contuct_us/bloc.dart';
import 'themar_screens/features/login/cubit.dart';
import 'themar_screens/features/products/cubit.dart';
import 'themar_screens/features/slider/cubit.dart';
import 'themar_screens/features/terms/cubit.dart';
import 'themar_screens/features/update_cart_item/bloc.dart';

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
