// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZ5RiXHOwhIB9xYeIKrQ-mAk4hozuYBK4',
    appId: '1:834059983805:web:110706302613f960d450d4',
    messagingSenderId: '834059983805',
    projectId: 'ecommerce-main-9bb15',
    authDomain: 'ecommerce-main-9bb15.firebaseapp.com',
    storageBucket: 'ecommerce-main-9bb15.appspot.com',
    measurementId: 'G-T7DXHFPKPG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMrZWzpJerJKSQWTBVBwbgnB8AHdfcbrU',
    appId: '1:834059983805:android:eba2543b6d4a3b34d450d4',
    messagingSenderId: '834059983805',
    projectId: 'ecommerce-main-9bb15',
    storageBucket: 'ecommerce-main-9bb15.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDysN4RhUlfixFs_s50o2Vef7frEXvRluA',
    appId: '1:834059983805:ios:6502ef47a7580ce0d450d4',
    messagingSenderId: '834059983805',
    projectId: 'ecommerce-main-9bb15',
    storageBucket: 'ecommerce-main-9bb15.appspot.com',
    iosBundleId: 'com.example.example',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDysN4RhUlfixFs_s50o2Vef7frEXvRluA',
    appId: '1:834059983805:ios:6502ef47a7580ce0d450d4',
    messagingSenderId: '834059983805',
    projectId: 'ecommerce-main-9bb15',
    storageBucket: 'ecommerce-main-9bb15.appspot.com',
    iosBundleId: 'com.example.example',
  );
}
