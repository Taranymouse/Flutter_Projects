import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // หลังจากที่ผู้ใช้ล็อกอินสำเร็จ เราจะดึง idToken โดยการเรียก getIdToken
    final User? user = userCredential.user;
    final idToken = await user?.getIdToken();  // ดึง idToken ที่แท้จริง

    if (user != null) {
      // ส่งคืน user พร้อม idToken
      return user;
    } else {
      return null;
    }
  }
}
