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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuzZOcD8c6t_lQJ3tjBczYJ0HfwKkf2bo',
    appId: '1:472535913302:android:7e88b112f51fc02775bcf7',
    messagingSenderId: '472535913302',
    projectId: 'striped-century-379318',
    storageBucket: 'striped-century-379318.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDblegoxFWAPz3W_XUjRSp_Hsby8Uz1XtI',
    appId: '1:472535913302:ios:c65317b16b255b6e75bcf7',
    messagingSenderId: '472535913302',
    projectId: 'striped-century-379318',
    storageBucket: 'striped-century-379318.appspot.com',
    androidClientId: '472535913302-ass2el9kthkuju6i2rju6ksed2p23167.apps.googleusercontent.com',
    iosClientId: '472535913302-mjulf0rk11vomikb1h73fg0apqr0fc74.apps.googleusercontent.com',
    iosBundleId: 'com.example.farmlyfe',
  );
}
