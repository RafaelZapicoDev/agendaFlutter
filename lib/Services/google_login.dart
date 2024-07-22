import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    // inciiando o processo de autenticação com o google
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // recebe ois dados da autenticação
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // criando uma nova credencial pro usuario
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    //fazendo login com as credenciais criadas
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
