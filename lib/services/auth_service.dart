import 'package:firebase_auth/firebase_auth.dart';
import 'package:stardias/data/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth change user stream
  Stream<UserModel?> get onAuthStateChanged {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userModelFromFirebase(user));
        .map(_userModelFromFirebase);
  }

  UserModel? _userModelFromFirebase(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  Future<UserModel?> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userModelFromFirebase(user);
    } catch (e) {
      print(e);
      return null;
      // return null if anything failed while logging with email and password.
    }
  }

  Future<UserModel?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userModelFromFirebase(user);
      //returned user can still be null, so check where we are calling this fn whether returned value is null or not
    } catch (e) {
      // return null if anything failed while logging in anonymously.
      return null;
    }
  }

  Future<UserModel?> registerWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userModelFromFirebase(user);
    } catch (e) {
      print(e);
      return null;
      // return null if anything failed while registering with email and password.
    }
  }
}
