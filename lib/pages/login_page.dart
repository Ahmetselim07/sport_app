import 'package:flutter/material.dart';
import 'package:sport_app/auth/auth_service.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Image.asset(
            'assets/images/fitness.png',
            width: 200,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          // email textfield
          MyTextfield(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),
          SizedBox(
            height: 10,
          ),
          // password textfield
          MyTextfield(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          SizedBox(
            height: 25,
          ),
          MyButton(
            text: 'Login',
            onTap: () => login(context),
          ),
          SizedBox(
            height: 25,
          ),
          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Üye değil misiniz? ',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Üye Ol',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
