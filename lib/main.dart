import 'package:flutter/material.dart';

import 'core/app.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

 // Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

