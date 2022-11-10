import 'package:flutter/material.dart';

class SuccessRegisterPage extends StatelessWidget {
  const SuccessRegisterPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Register Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text ('You have successfully registered', style: TextStyle(fontSize:20),),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              Navigator.popUntil(context, (route) => route.isFirst);
            }, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}