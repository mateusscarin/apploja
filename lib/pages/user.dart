import 'package:apploja/main.dart';
import 'package:apploja/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _searchController = TextEditingController();

  bool _editForm = false;
  String _editId = "";

  // Função para criar ou atualizar usuário no Firebase
  Future<void> _saveUser() async {
    if (_nameController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      UserModel userModel = UserModel(
        name: _nameController.text,
        cpf: _cpfController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      if (_editForm) {
        // Atualizar usuário
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_editId)
            .update(userModel.toJson());
        setState(() {
          _editForm = false;
          _editId = '';
        });
      } else {
        // Criar novo usuário
        final docRef = FirebaseFirestore.instance.collection('users').doc();
        await docRef.set(userModel.toJson());
      }

      // Limpar campos após o envio
      _nameController.clear();
      _cpfController.clear();
      _phoneController.clear();
      _emailController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(_editForm ? 'Usuário atualizado!' : 'Usuário criado!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, preencha todos os campos.')));
    }
  }

  // Função para editar o usuário
  void _editUser(UserModel userModel) {
    setState(() {
      _nameController.text = userModel.name;
      _cpfController.text = userModel.cpf;
      _phoneController.text = userModel.phone;
      _emailController.text = userModel.email;
      _editForm = true;
      _editId = userModel.id!;
    });
  }

  // Função para excluir usuário
  Future<void> _deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Usuário excluído com sucesso!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD de Usuários'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cadastro de Usuário',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            _buildTextField(_nameController, 'Nome', Icons.person),
            const SizedBox(height: 10.0),
            _buildTextField(_cpfController, 'CPF', Icons.credit_card),
            const SizedBox(height: 10.0),
            _buildTextField(_phoneController, 'Telefone', Icons.phone),
            const SizedBox(height: 10.0),
            _buildTextField(_emailController, 'Email', Icons.email),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _saveUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyApp.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  Text(_editForm ? 'Atualizar Usuário' : 'Cadastrar Usuário'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Text('Nenhum usuário encontrado.');
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      UserModel userModel = UserModel.fromDocument(doc);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                          title: Text(userModel.name),
                          subtitle: Text(
                              'Email: ${userModel.email} - Telefone: ${userModel.phone}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _editUser(userModel),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteUser(userModel.id!),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para simplificar os campos de texto
  Widget _buildTextField(
      TextEditingController controller, String labelText, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
