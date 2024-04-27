import 'package:flutter/material.dart';
import 'package:sport_app/auth/auth_service.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    // auth serviceten getir

    final _auth = AuthService();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
      }
      // şifreler eşleşmezse hata göster
     
    }
     else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Şifreler eşleşmedi!"),
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
            height: 10,
          ),
          MyTextfield(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          SizedBox(
            height: 25,
          ),
          MyButton(
            text: 'Register',
            onTap: () => register(context),
          ),
          SizedBox(
            height: 25,
          ),
          // register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hesabınız var mı? ',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  'Giriş Yap',
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
