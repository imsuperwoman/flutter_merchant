import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:mse_customer/providers/auth_provider.dart';
import 'package:mse_customer/providers/request_provider.dart';
import 'package:mse_customer/providers/user_provider.dart';
import 'package:mse_customer/screens/login.dart';
import 'package:mse_customer/translations/codegen_loader.g.dart';
import 'package:mse_customer/util/custom_colors.dart';
import 'package:mse_customer/util/locator.dart';
import 'package:mse_customer/util/page_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('ms'),
          // Locale('zh', 'CN')
        ],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => RequestProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: customTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Login(),
          routes: PageRoutes().routes(),
        ));
  }
}
