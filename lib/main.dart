import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/mock_data.dart';
import 'package:flutter_application_1/features/common/presentation/pages/cnw_worker_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/intl_volunteer_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/login_page.dart';
import 'package:flutter_application_1/features/common/presentation/pages/promoter_entity_worker_page.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAu8f2LNnIJgf2K29lcLfdmRYwS7X8kxJ4",
      appId: "com.example.flutter_application_1",
      messagingSenderId: "284843891114",
      projectId: "flutterapplication1-d3376",
    ),
  );
  //Firebase Foi Conectado aqui Com recurso Firebase CLI e executando firebase init
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestão de Voluntários',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      // home: IntlVolunteerPage(intlVolunteer: mockIntlVolunteer,),
      // home: CnvWorkerPage(cnvWorker: mockCnvWorker),
      // home: PromoterEntityWorkerPage(promoterEntityWorker: mockPEWorkerModel),
    );
  }
}
/*
  funcionario.ep@mail.com -> 123456Q!
  funcionario.cnv@mail.com -> 123456Q!
*/