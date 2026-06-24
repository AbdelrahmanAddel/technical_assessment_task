import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();
  runApp(const App());
}
