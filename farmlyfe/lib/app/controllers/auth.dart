import 'package:farmlyfe/app/configs/routes.dart';
import 'package:farmlyfe/app/widgets/dialog.dart';
import 'package:farmlyfe/app/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  // Services
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Observables
  final Rx<User?> _currentUser = Rx<User?>(null);

  // Getters
  User? get getUser => _currentUser.value;

  // Setters
  void setUser(User? user) {
    _currentUser.value = user;
  }

  login() async {
    // Show the loading indicator
    LoadingDialogWidget.open();

    try {
      // Google sign in with firebase auth with catch for errors
      _googleSignIn.signIn().then((googleUser) {
        googleUser?.authentication.then((googleAuth) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          _firebaseAuth.signInWithCredential(credential).then((userCredential) {
            // Check if the userCredential is valid
            if (userCredential.user != null) {
              // Set the user
              setUser(userCredential.user);

              // Close the loading indicator
              LoadingDialogWidget.close();

              // Check if the user is new
              if (userCredential.additionalUserInfo!.isNewUser) {
                // Navigate to the crop page
                Get.toNamed(FarmLyfeRoutes.crop);
              } else {
                // Navigate to the profile page
                Get.toNamed(FarmLyfeRoutes.weather);
              }
            } else {
              throw 'Invalid user';
            }
          }).catchError((error) {
            throw error;
          });
        }).catchError((error) {
          throw error;
        });
      }).catchError((error) {
        throw error;
      });
    } catch (e) {
      // Close the loading indicator
      LoadingDialogWidget.close();

      SnackbarWidget.showError(e.toString());
    }
  }

  logout() async {
    SnackbarWidget.showInfo('Logging out...');

    try {
      // Firebase sign out
      _firebaseAuth.signOut().then((value) {
        // Google sign out
        _googleSignIn.signOut().then((value) {
          // Clear the user
          setUser(null);

          // Navigate to the auth page
          Get.offAllNamed(FarmLyfeRoutes.auth);
        }).catchError((error) {
          throw error;
        });
      }).catchError((error) {
        throw error;
      });
    } catch (e) {
      SnackbarWidget.showError(e.toString());
    }
  }
}
