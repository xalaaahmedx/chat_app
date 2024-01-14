import 'package:chatapp/services/auth/auth_sarvice.dart';
import 'package:chatapp/widgets/TextField.dart';
import 'package:chatapp/widgets/my_buttons.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screen/LogIn.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.onTap});
  final void Function()? onTap;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('passwords are not matching!')));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Icon(
                    Icons.message,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Lets create an account for you',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MyTextField(
                    controller: _emailController,
                    obsecureText: false,
                    hintText: 'Enter Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: _passwordController,
                      obsecureText: true,
                      hintText: 'Enter Password'),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      controller: _confirmPasswordController,
                      obsecureText: true,
                      hintText: 'confirm Password'),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButtons(
                    text: 'SignUp',
                    onTap: _signUp,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('already a member? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text('Signin'),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
