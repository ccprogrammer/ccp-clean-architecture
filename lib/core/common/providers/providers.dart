import 'package:ccp_clean_architecture/core/common/providers/app_provider.dart';
import 'package:ccp_clean_architecture/src/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers => [..._providers, ..._blocProviders];

// For Provider package
// put your provider inside this list
List<SingleChildWidget> _providers = [
  ChangeNotifierProvider(
    lazy: false,
    create: (_) => AppProvider()..init(),
  ),
];

// For flutter_bloc package
// put your bloc inside this list
List<SingleChildWidget> _blocProviders = [
  BlocProvider(create: (_) => AuthBloc()),
];
