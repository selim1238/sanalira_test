import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:sanalira_test/pages/login.dart';
import 'package:sanalira_test/pages/main_menu.dart';
import 'package:sanalira_test/pages/top_up.dart';
import 'package:sanalira_test/utility/colors.dart';
import 'package:sanalira_test/utility/firebase/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.green,
          unselectedWidgetColor: Colors.white),
      home: ChangeNotifierProvider(
        create: (context) => FirebaseLoginProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<FirebaseLoginProvider>(context);
            if (provider.isSigningIn) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return MainMenu();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}
