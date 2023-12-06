import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:outstock/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  final String userEmail;
  final String userPassword;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserController({required this.userEmail, required this.userPassword});

  Future<String?> login() async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error ${e.code}');
      switch (e.code) {
        case "invalid-email":
          return "E-mail inválido";
        case "invalid-credential":
          return "Credenciais Inválidas";
        case "network-request-failed":
          return "Erro de conexão";
        case "too-many-requests":
          return "Muitas tentativas, aguarde.";
        default:
          return "Ocorreu um erro";
      }
    }
  }

  Future<String?> createAccount() async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: userEmail.trim(), password: userPassword.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error ${e.code}');
      switch (e.code) {
        case "email-already-in-use":
          return "E-mail já utilizado";
        case "invalid-email":
          return "E-mail inválido";
        case "operation-not-allowed":
          return "Este modo de login foi desabilitado";
        case "weak-password":
          return "Senha não segue as exigências";
        default:
          return "Ocorreu um erro";
      }
    }
  }

  Future<void> changePassword(String newPassword) async {
    await auth.currentUser!.updatePassword(newPassword);
  }

  static Future<void> Function() logout =
      () async => await FirebaseAuth.instance.signOut();
}
