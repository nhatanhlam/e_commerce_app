import 'package:e_commerce_app/app/app.dart';
import 'package:e_commerce_app/config/admin_config.dart';
import 'package:e_commerce_app/config/flavor_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// flutter run --flavor admin -t .\lib\main_admin.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlavorConfig(
    flavor: Flavor.admin,
    flavorValues: FlavorValues(
      roleConfig: AdminConfig(),
    ),
  );

  runApp(
    const App(),
  );
}
