import 'package:fauzi_portofolio/core/services/injection_container.dart';
import 'package:fauzi_portofolio/src/profile/presentation/cubit/profile_cubit.dart';
import 'package:fauzi_portofolio/src/profile/presentation/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: MaterialApp(
        title: 'Fauzi Portofolio',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
            titleSmall: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}