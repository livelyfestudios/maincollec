import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MainCollec2FirebaseUser {
  MainCollec2FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MainCollec2FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MainCollec2FirebaseUser> mainCollec2FirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MainCollec2FirebaseUser>(
        (user) => currentUser = MainCollec2FirebaseUser(user));
