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
    apiKey: 'AIzaSyCL4yliKZQt0FzI7EiSjAT9Ofgo6qvgZ70',
    appId: '1:606801285091:web:2029cfd7e4e02de08e5ad6',
    messagingSenderId: '606801285091',
    projectId: 'firstfireapp-9f572',
    authDomain: 'firstfireapp-9f572.firebaseapp.com',
    storageBucket: 'firstfireapp-9f572.firebasestorage.app',
    measurementId: 'G-VFEEP9X3L3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHHr4v0i9yccjBt6f3Jkk1-Up2j2pZ1xk',
    appId: '1:606801285091:android:66132c32f3937e648e5ad6',
    messagingSenderId: '606801285091',
    projectId: 'firstfireapp-9f572',
    storageBucket: 'firstfireapp-9f572.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_Aub0jsvzKPWEtckCbAJHrb8uZh01zJ8',
    appId: '1:606801285091:ios:f7d7df028763b1b08e5ad6',
    messagingSenderId: '606801285091',
    projectId: 'firstfireapp-9f572',
    storageBucket: 'firstfireapp-9f572.firebasestorage.app',
    iosBundleId: 'com.example.firstapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_Aub0jsvzKPWEtckCbAJHrb8uZh01zJ8',
    appId: '1:606801285091:ios:f7d7df028763b1b08e5ad6',
    messagingSenderId: '606801285091',
    projectId: 'firstfireapp-9f572',
    storageBucket: 'firstfireapp-9f572.firebasestorage.app',
    iosBundleId: 'com.example.firstapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCL4yliKZQt0FzI7EiSjAT9Ofgo6qvgZ70',
    appId: '1:606801285091:web:26996bf01ed706338e5ad6',
    messagingSenderId: '606801285091',
    projectId: 'firstfireapp-9f572',
    authDomain: 'firstfireapp-9f572.firebaseapp.com',
    storageBucket: 'firstfireapp-9f572.firebasestorage.app',
    measurementId: 'G-GNWSBBDJC9',
  );
}
