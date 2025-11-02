
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text('Login with Google'),
                onPressed: () {
                  // TODO: Implement Google Login
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // No action for now
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
