import 'package:firebase_test/SuccessRegister.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SuccessRegister.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Login'),
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value){
                email = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value){
                password = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async{
              try{
                final newUser = await _authentication.createUserWithEmailAndPassword(email: email, password: password);
                if(newUser.user != null){
                  _formKey.currentState!.reset();
                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessRegisterPage()));
                }
              }
              catch (e){
                print(e);
              }
              }, child: const Text('Enter')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('If you already registered,'),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Login')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
