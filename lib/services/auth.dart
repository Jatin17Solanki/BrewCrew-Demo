import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user object based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
      //or
    //.map(_userFromFirebaseUser);
  }

  //sign in anonymous
    Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async { // sign... here is simply a function name
    try {

      //Note: signInWithEmailAndPassword() here is an inbuilt function of the auth library
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e) {
       print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); 
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid : user.uid).updateUserData('0', 'new Member', 100);
      return _userFromFirebaseUser(user);

    } catch(e) {
       print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async { // signOut() here is simply a function name
    try
    {
      return await _auth.signOut(); //Note: signOut() here is an inbuilt function of the auth library
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}