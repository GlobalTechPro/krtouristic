import 'package:krtouristic/conf/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          // print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
        // print("Unknown error.");
      }
    }
    return FirebaseService();
  }
}
