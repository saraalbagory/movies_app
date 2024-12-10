import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:movies_app/features/authentication/data/models/login_parameters.dart';
import 'package:movies_app/features/authentication/data/models/register_parameters.dart';
import 'package:movies_app/features/authentication/data/models/user_data_model.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> register(RegisterParameters registerParameters,
      UserDataModel userDataModel) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: registerParameters.email,
      password: registerParameters.password,
    );
    userDataModel.id = userCredential.user?.uid;
    print(userDataModel.id);
    print(userDataModel.name);
    await addUserToFB(userDataModel);
    return userCredential.user;
  }

  @override
  Future<User?> login(LoginParameters loginParameters) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: loginParameters.email,
      password: loginParameters.password,
    );
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  static CollectionReference<UserDataModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserDataModel>(
          fromFirestore: (snapshot, _) =>
              UserDataModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  @override
  Future<void> addUserToFB(UserDataModel usermodel) async {
    final usersCollection = getUserCollection();
    await usersCollection.doc(usermodel.id).set(usermodel);
  }

  // @override
  // Future<String> forgotPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }
}
