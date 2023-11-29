import 'package:flutter/material.dart';

class SignInSSO extends StatelessWidget {
  const SignInSSO({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: const Row(
            children: [
              Expanded(child: Divider()),
              Text('   OR   '),
              Expanded(child: Divider()),
            ],
          ),
        ),
      ],
    );
  }
}
