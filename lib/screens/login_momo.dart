import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/app_colors.dart';

class LoginMomo extends StatefulWidget {
  const LoginMomo({super.key});

  @override
  LoginMomoState createState() => LoginMomoState();
}

class LoginMomoState extends State<LoginMomo> {
  bool _obscurePassword = true;

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: FaIcon(icon, color: Colors.black87),
        label: Text(text, style: TextStyle(color: Colors.black87)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.tertiaryLight,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/momo_logo_4x.png',
                    width: 200,
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Usa tu cuenta para ingresar',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: _navigateToHome,
                      child: Text(
                        'Ingresar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    child: Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.google,
                    text: 'Continuar con Google',
                    onPressed: _navigateToHome,
                  ),
                  _buildSocialButton(
                    icon: FontAwesomeIcons.apple,
                    text: 'Continuar con Apple',
                    onPressed: _navigateToHome,
                  ),
                  SizedBox(height: 10),
                  _buildSocialButton(
                    icon: Icons.person_outline,
                    text: 'Continuar como invitado',
                    onPressed: _navigateToHome,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
