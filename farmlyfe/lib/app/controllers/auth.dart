import 'package:cloud_firestore/cloud_firestore.dart';
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
        // Check if user cancelled the sign in
        if (googleUser == null) {
          // Close the loading indicator
          LoadingDialogWidget.close();

          return;
        }
        
        googleUser.authentication.then((googleAuth) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          _firebaseAuth.signInWithCredential(credential).then((userCredential) {
            // Check if the userCredential is valid
            if (userCredential.user != null) {
              // Set the user
              setUser(userCredential.user);

              // Check if user email is in favorites collection
              hasFavorite(userCredential).then((valueRef) {
                // Get query snapshot from reference
                valueRef.get().then((value) {
                  // Close the loading indicator
                  LoadingDialogWidget.close();

                  // Navigate to the home page
                  Get.toNamed(FarmLyfeRoutes
                      .pagesMap[FarmLyfeRoutes.initialPage] as String);
                }).catchError((error) {
                  throw error;
                });
              }).catchError((error) {
                throw error;
              });
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

  // Function t0 check if user email in favorite collection
  Future<DocumentReference> hasFavorite(UserCredential userCredential) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('email', isEqualTo: userCredential.user?.email)
        .get();

    // Check if querySnapshot is empty
    if (querySnapshot.docs.isEmpty) {
      // Add user email to favorites collection
      return FirebaseFirestore.instance.collection('favorites').add({
        'email': userCredential.user?.email,
        'crops': [],
      });
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('email', isEqualTo: userCredential.user?.email)
          .get();

      return querySnapshot.docs.first.reference;
    }
  }
}
