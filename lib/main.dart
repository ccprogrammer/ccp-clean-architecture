import 'dart:async';
import 'dart:developer';

import 'package:ccp_clean_architecture/core/common/providers/app_provider.dart';
import 'package:ccp_clean_architecture/core/common/providers/providers.dart';
import 'package:ccp_clean_architecture/core/config/theme/app_theme.dart';
import 'package:ccp_clean_architecture/core/injections/injection.dart';
import 'package:ccp_clean_architecture/core/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  FlutterError.onError = (details) {
    if (kDebugMode) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    }
  };

  // Error zone wrapper in case something went error and cause the screen to be blank
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Injection.init();

      runApp(
        const App(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

// This widget is the root of your application.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: const _App(),
    );
  }
}

/// This widget should be separated from [App]
/// if not it will throw error because
/// the providers cannot lookup on the same [BuildContext] 
class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'CCP Clean Architecture',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<AppProvider>().isLightModeOn,
    );
  }
}
