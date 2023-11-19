import 'dart:async';
import 'dart:developer';

import 'package:ccp_clean_architecture/core/common/providers/providers.dart';
import 'package:ccp_clean_architecture/core/config/theme/app_theme.dart';
import 'package:ccp_clean_architecture/core/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

      // await Injection.init();

      runApp(const App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

// This widget is the root of your application.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'CCP Clean Architecture',
      theme: AppTheme.getThemeData(
        isLightTheme: true,
      ),
    );
  }
}
