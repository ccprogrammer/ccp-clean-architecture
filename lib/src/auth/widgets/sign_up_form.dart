import 'package:ccp_clean_architecture/core/config/theme/app_colors.dart';
import 'package:ccp_clean_architecture/core/extensions/context_ext.dart';
import 'package:ccp_clean_architecture/src/auth/views/sign_in_screen.dart';
import 'package:ccp_clean_architecture/src/auth/views/sign_up_screen.dart';
import 'package:ccp_clean_architecture/src/home/views/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            alignment: Alignment.topLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: context.theme.textTheme.headlineLarge
                        ?.copyWith(height: 0),
                  ),
                  const TextSpan(text: '\n\n'),
                  const TextSpan(
                    text:
                        'Welcome to Workaholic! Please sign up to continue...',
                  ),
                  const TextSpan(text: '\n\n'),
                  const TextSpan(
                    text: 'Already have an account?',
                  ),
                  TextSpan(
                    text: ' Sign in',
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryLight,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.go(SignInScreen.route),
                  ),
                ],
              ),
              style: context.theme.textTheme.bodyLarge,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your Password',
              labelText: 'Password',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go(HomeScreen.route),
              child: const Text('Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
