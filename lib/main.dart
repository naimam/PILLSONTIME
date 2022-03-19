import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/providers/init_provider.dart';
import 'package:project/utils/config.dart';

final configurations = Configurations();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("WEB");
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: configurations.apiKey,
        appId: configurations.appId,
        authDomain: configurations.authDomain,
        storageBucket: configurations.storageBucket,
        messagingSenderId: configurations.messagingSenderId,
        projectId: configurations.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
    print("MOBILE");
  }
  runApp(InitProvider());
}
