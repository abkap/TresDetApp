library auth.globals;

import 'package:firebase_auth/firebase_auth.dart';

User? user;

fetchUserFromFirebase() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  user = _auth.currentUser;
  //print(auth_globals.user?.email);
}
