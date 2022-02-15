import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ZoukhappFirebaseUser {
  ZoukhappFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ZoukhappFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ZoukhappFirebaseUser> zoukhappFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ZoukhappFirebaseUser>(
            (user) => currentUser = ZoukhappFirebaseUser(user));
