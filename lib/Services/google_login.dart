import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "34198666131-9a0mbn3mu818n0mb025c9tjpc66pilf9.apps.googleusercontent.com");

  Future<User?> signInWithGoogle() async {
    try {
      // Iniciando o processo de autenticação com o Google
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        throw Exception('Falha em logar');
      }
      // Recebendo os dados da autenticação
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      // Criando uma nova credencial para o usuário
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      // Fazendo login com as credenciais criadas
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro ao autenticar com o Google: ${e.message}');
      return null;
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      return true;
    } on Exception catch (e) {
      print('Erro ao deslogar: $e');
      return false;
    }
  }
}
