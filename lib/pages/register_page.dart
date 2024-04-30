import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport_app/pages/profile_page.dart';
import 'package:sport_app/services/auth/auth_service.dart';
import 'package:sport_app/components/my_button.dart';
import 'package:sport_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    final _auth = AuthService();
    final _firestore = FirebaseFirestore.instance;
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        // Firebase Authentication ile kullanıcıyı kaydet
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );

        // Firebase Firestore'a kullanıcı bilgilerini ekle
        await _firestore.collection('users').doc(_auth.getCurrentUser()!.uid).set({
          'name': _nameController.text,
          'surname': _surnameController.text,
          'height': _heightController.text,
          'weight': _weightController.text,
        });

        // Kullanıcı başarıyla kaydedildi, bir mesaj göster ve profil sayfasına yönlendir
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kullanıcı başarıyla kaydedildi'),
          ),
        );

        // Profil sayfasına yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } catch (e) {
       await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Image.asset(
                'assets/images/fitness.png',
                width: 200,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              // email textfield
              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              SizedBox(height: 10),
              // password textfield
              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Name',
                obscureText: false,
                controller: _nameController,
              ),
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Surname',
                obscureText: false,
                controller: _surnameController,
              ),
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Height',
                obscureText: false,
                controller: _heightController,
              ),
              SizedBox(height: 10),
              MyTextfield(
                hintText: 'Weight',
                obscureText: false,
                controller: _weightController,
              ),
              SizedBox(height: 25),
              MyButton(
                text: 'Register',
                onTap: () => register(context),
              ),
              SizedBox(height: 25),
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
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
