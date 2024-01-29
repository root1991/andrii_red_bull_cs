import 'package:flutter/material.dart';
import 'package:red_bull_case_study/di/app_module.dart';
import 'package:red_bull_case_study/presentation/redbull_application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appModule = AppModule();
  await appModule.initDependencies();

  runApp(
    RedBullApplication(
      appModule: appModule,
    ),
  );
}

