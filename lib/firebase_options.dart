// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAxiFhGhv8nRFLyA-uu_7JbAwWFV9EA304',
    appId: '1:411543491104:web:0130da4fbfac47e69be245',
    messagingSenderId: '411543491104',
    projectId: 'shopfinder5',
    authDomain: 'shopfinder5.firebaseapp.com',
    storageBucket: 'shopfinder5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFkCc_CCk80uWSD0dj0-FnhOx_0LNbQQ4',
    appId: '1:411543491104:android:5f23bfb395a366df9be245',
    messagingSenderId: '411543491104',
    projectId: 'shopfinder5',
    storageBucket: 'shopfinder5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5eFM6C4APPGRZrIl-C8NptPWTGsOHHMQ',
    appId: '1:411543491104:ios:fd9d09944b55e6419be245',
    messagingSenderId: '411543491104',
    projectId: 'shopfinder5',
    storageBucket: 'shopfinder5.appspot.com',
    androidClientId: '411543491104-7n7fuc85suj94u8jnrdoq7np3g7dib70.apps.googleusercontent.com',
    iosClientId: '411543491104-ns2nd3ql37j5n3abdh3db25as9fek58u.apps.googleusercontent.com',
    iosBundleId: 'com.example.cateringweb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5eFM6C4APPGRZrIl-C8NptPWTGsOHHMQ',
    appId: '1:411543491104:ios:fd9d09944b55e6419be245',
    messagingSenderId: '411543491104',
    projectId: 'shopfinder5',
    storageBucket: 'shopfinder5.appspot.com',
    androidClientId: '411543491104-7n7fuc85suj94u8jnrdoq7np3g7dib70.apps.googleusercontent.com',
    iosClientId: '411543491104-ns2nd3ql37j5n3abdh3db25as9fek58u.apps.googleusercontent.com',
    iosBundleId: 'com.example.cateringweb',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAxiFhGhv8nRFLyA-uu_7JbAwWFV9EA304',
    appId: '1:411543491104:web:0130da4fbfac47e69be245',
    messagingSenderId: '411543491104',
    projectId: 'shopfinder5',
    authDomain: 'shopfinder5.firebaseapp.com',
    storageBucket: 'shopfinder5.appspot.com',
  );
}