import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_hub/core/di/injection.dart';
import 'package:service_hub/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:service_hub/features/auth/presentation/pages/login_page.dart';
import 'package:service_hub/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => getit<AuthCubit>(),
        child: const LoginPage(),
      ),
    );
  }
}

class ServiceHubApp extends StatefulWidget {
  const ServiceHubApp({super.key});

  @override
  State<ServiceHubApp> createState() => _ServiceHubAppState();
}

class _ServiceHubAppState extends State<ServiceHubApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('ServiceHub')));
  }
}
