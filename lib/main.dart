import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const JaibaArApp());
}

class JaibaArApp extends StatelessWidget {
  const JaibaArApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JaibaAR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}