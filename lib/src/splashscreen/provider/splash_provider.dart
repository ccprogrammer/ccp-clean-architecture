import 'package:ccp_clean_architecture/core/common/models/user_model.dart';
import 'package:ccp_clean_architecture/core/common/providers/app_provider.dart';
import 'package:ccp_clean_architecture/core/data/local/shared_preferences/my_shared_preferences.dart';
import 'package:ccp_clean_architecture/src/auth/views/sign_in_screen.dart';
import 'package:ccp_clean_architecture/src/on_boarding/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> initState(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    // if user initialize the app for first time it will navigate to on boarding
    if (Prefs.getIsFirstTimer()) {
      Prefs.setIsFirstTimer();
      context.go(OnBoardingScreen.route);
      return;
    }

    await initAuthState(context);
  }

  // and do authentication validation
  Future<void> initAuthState(BuildContext context) async {
    // Future getUser ... call user api repository here

    final localUser = UserModel(
      uid: 'dsu9fy138947dg24',
      name: 'Lubianca',
      email: 'dcorvo87@gmail.com',
      phone: '+6285880853298',
    );

    context.read<AppProvider>().initUser(localUser);

    context.go(SignInScreen.route);
  }
}
