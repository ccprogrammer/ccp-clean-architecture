import 'package:ccp_clean_architecture/core/testing/bloc/testing_bloc.dart';
import 'package:ccp_clean_architecture/src/auth/widgets/sign_in_form.dart';
import 'package:ccp_clean_architecture/src/auth/widgets/sign_in_sso.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const route = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TestingBloc>().add(const OnTapTestingEvent());
        },
        child: const Icon(Icons.bug_report),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: double.infinity,
              constraints: const BoxConstraints(
                maxHeight: 120,
              ),
            ),
            const SignInForm(),
            const SignInSSO(),
          ],
        ),
      ),
    );
  }
}
