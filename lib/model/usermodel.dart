import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String cpf;
  final String phone;
  final String email;
  final String? id;

  UserModel(
      {required this.name,
      required this.cpf,
      required this.phone,
      required this.email,
      this.id});

  //do Json para dados
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      cpf: doc['cpf'],
      phone: doc['phone'],
      email: doc['email'],
    );
  }
  toJson() {
    return {'name': name, 'cpf': cpf, 'phone': phone, 'email': email, 'id': id};
  }
}
