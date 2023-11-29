import 'package:ccp_clean_architecture/src/auth/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const route = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: double.infinity,
              constraints: const BoxConstraints(
                maxHeight: 120,
              ),
            ),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
