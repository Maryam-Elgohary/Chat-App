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
    apiKey: 'AIzaSyAccpXSD7PaocNaPGy-t0jFaRo2f9R4aBM',
    appId: '1:587829278824:web:12035b4ccf5900c8a763dd',
    messagingSenderId: '587829278824',
    projectId: 'chat-app-50f8c',
    authDomain: 'chat-app-50f8c.firebaseapp.com',
    storageBucket: 'chat-app-50f8c.appspot.com',
    measurementId: 'G-MZ4EV707YV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuNz0w3qlC2XlkfdPA_3O74C9Ml_3FOBU',
    appId: '1:587829278824:android:de6e76925accbcd5a763dd',
    messagingSenderId: '587829278824',
    projectId: 'chat-app-50f8c',
    storageBucket: 'chat-app-50f8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuodbg5Dg90y_KTqGIDP-Vqy905p-gm6U',
    appId: '1:587829278824:ios:1a8bfc6327321933a763dd',
    messagingSenderId: '587829278824',
    projectId: 'chat-app-50f8c',
    storageBucket: 'chat-app-50f8c.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuodbg5Dg90y_KTqGIDP-Vqy905p-gm6U',
    appId: '1:587829278824:ios:1a8bfc6327321933a763dd',
    messagingSenderId: '587829278824',
    projectId: 'chat-app-50f8c',
    storageBucket: 'chat-app-50f8c.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAccpXSD7PaocNaPGy-t0jFaRo2f9R4aBM',
    appId: '1:587829278824:web:367df044908b491fa763dd',
    messagingSenderId: '587829278824',
    projectId: 'chat-app-50f8c',
    authDomain: 'chat-app-50f8c.firebaseapp.com',
    storageBucket: 'chat-app-50f8c.appspot.com',
    measurementId: 'G-6NQD4RK3XT',
  );
}
