import 'package:api/core/logic/cache_helper.dart';
import 'package:api/core/logic/helper.dart';
import 'package:api/themar_screens/features/login/login_view.dart';
import 'package:api/themar_screens/features/register/view.dart';
import 'package:api/themar_screens/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/logic/app_theme.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  initServiceLocator();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
        Locale("fr"),
      ],
      path: "assets/translations",
      fallbackLocale: Locale("en"),
      startLocale: Locale("ar"),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: child),
      child: const Views(),
    );
  }
}
