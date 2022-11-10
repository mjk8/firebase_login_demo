import 'package:firebase_test/ChatPage.dart';
import 'package:firebase_test/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'ChatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Login'),
      ),
      body: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
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
                  setState(() {
                    showSpinner = true;
                  });
                  final currentUser = await _authentication.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (currentUser.user != null){
                    _formKey.currentState!.reset();
                    if (!mounted) return;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChatPage()));
                    setState(() {
                      showSpinner = false;
                    });
                  }
                }
                catch(e){
                  print(e);
                }
                },
                  child: const Text('Enter')),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('If you did not register,'),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: const Text('Sign up')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
