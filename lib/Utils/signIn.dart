import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name;
String email;
String imageUrl;

bool isSignedIn = false;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  assert(user.email != null);
assert(user.displayName != null);
assert(user.photoUrl != null);

name = user.displayName;
email = user.email;
imageUrl = user.photoUrl;

if (name.contains(" ")) {
   name = name.substring(0, name.indexOf(" "));
}

  SharedPreferences prefs = await SharedPreferences.getInstance();
      //_counter = (prefs.getInt('counter') ?? 0) + 1;
      //name = (prefs.getString('username')) : (prefs.setString('username', name));
      prefs.setBool('isUserSigned', true);

  return 'signInWithGoogle succeeded: $user';
}



void signOutGoogle() async{
  await googleSignIn.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setBool('isUserSigned', false);
  prefs.setString('username', null);
  prefs.setString('userimage', null);

  print("User Sign Out");
}

