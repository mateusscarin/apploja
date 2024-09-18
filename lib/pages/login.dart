import 'package:apploja/pages/user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("LOGIN")),
      backgroundColor:
          Colors.grey[200], // Altere a cor de fundo conforme necessário
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20.0), // Bordas arredondadas
                image: DecorationImage(
                  image: AssetImage('assets/cartoes.png'), // Caminho da imagem
                  fit: BoxFit.cover,
                ),
              ),
              height: 100.0, // Ajuste o tamanho conforme necessário
            ),
            const SizedBox(height: 15.0), // Espaço entre a imagem e o texto
            const Text(
              "Qual sua função?",
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AdminHomePage(),
                //   ),
                // );
              },
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 14, 105, 170),
                  border: Border.all(
                    color: const Color.fromARGB(255, 14, 105, 170),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    "ADMIN",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserHomePage(),
                  ),
                );
              },
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 14, 105, 170),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    "USER",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
