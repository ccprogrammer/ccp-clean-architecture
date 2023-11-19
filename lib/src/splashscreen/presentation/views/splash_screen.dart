import 'package:ccp_clean_architecture/core/data/network/api/api_client.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ApiClient.testApiClient,
      ),
      body: Center(
        child: Text('SplashScreen'),
      ),
    );
  }
}
