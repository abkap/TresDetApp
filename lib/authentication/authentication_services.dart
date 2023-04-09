import 'package:firebase_auth/firebase_auth.dart';

import 'auth_global_credentials.dart' as auth_globals;

signOut() async {
  try {
    await FirebaseAuth.instance.signOut().then((value) => {
          auth_globals.user = null,
        });
    return auth_globals.user == null
        ? ('signout successfull')
        : ('signout failed');
  } catch (e) {
    return ('Something went wrong! try again...');
  }
}

signIn({String? email, String? password}) async {
  if (email != null && password != null) {
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                auth_globals.user = value.user,
              });
      return auth_globals.user != null
          ? ('login successfull')
          : ('login failed');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password');
      }
    } catch (e) {
      return ('Something went wrong! try again...');
    }
  }
}

signUp({String? email, String? password, String? name}) async {
  if (email.toString().isNotEmpty && password.toString().isNotEmpty) {
    try {
      if (email != null && password != null) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((value) => {
                  auth_globals.user = value.user,
                  auth_globals.user?.updateDisplayName(name),
                });

        return auth_globals.user != null
            ? ('signup successfull')
            : ('signup failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('Week password');
      } else if (e.code == 'email-already-in-use') {
        return ('Account already exists');
      }
    } catch (e) {
      return ('Something went wrong! try again...');
    }
  }
}

passwordReset(String? email) async {
  try {
    if (email != null) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return ('success');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return ('No user found');
    }
  } catch (e) {
    return ('Something went wrong! try again...');
  }
}
