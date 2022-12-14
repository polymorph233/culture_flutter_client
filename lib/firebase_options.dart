// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADVOUuLyBtqKAa_vGB6UZEBc5irZWMo7w',
    appId: '1:767534342700:android:4fb8a85cc47adf3c432789',
    messagingSenderId: '767534342700',
    projectId: 'hackathon2022istic-46ff0',
    databaseURL:
        'https://hackathon2022istic-46ff0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hackathon2022istic-46ff0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYLjehjzNmMBJscFU3pt9I5LluHmXZFB0',
    appId: '1:767534342700:ios:60c8b5ba9aad5fc9432789',
    messagingSenderId: '767534342700',
    projectId: 'hackathon2022istic-46ff0',
    databaseURL:
        'https://hackathon2022istic-46ff0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hackathon2022istic-46ff0.appspot.com',
    iosClientId:
        '767534342700-dr0vs8dndqm4qtsp4mqbu946f3eq2fq3.apps.googleusercontent.com',
    iosBundleId: 'com.example.cultureFlutterClient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYLjehjzNmMBJscFU3pt9I5LluHmXZFB0',
    appId: '1:767534342700:ios:60c8b5ba9aad5fc9432789',
    messagingSenderId: '767534342700',
    projectId: 'hackathon2022istic-46ff0',
    databaseURL:
        'https://hackathon2022istic-46ff0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hackathon2022istic-46ff0.appspot.com',
    iosClientId:
        '767534342700-dr0vs8dndqm4qtsp4mqbu946f3eq2fq3.apps.googleusercontent.com',
    iosBundleId: 'com.example.cultureFlutterClient',
  );
}
