import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';

class AuthDataSourceImpl extends AuthDataSource{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> register(RegisterParameters registerParameters) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: registerParameters.email,
      password: registerParameters.password,
    );
    return userCredential.user;
  }

  @override
  Future<User?> login(LoginParameters loginParameters) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: loginParameters.email,
      password: loginParameters.password,
    );
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  // @override
  // Future<String> forgotPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }
}