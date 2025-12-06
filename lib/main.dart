import 'package:flutter/material.dart';
import 'package:responsi2mobile_paket3h1d023107/helpers/user_info.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/login_page.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const BukuPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi 2 Isma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFEFEBE9), 
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown, 
          foregroundColor: Colors.white, 
          elevation: 0,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown, 
            foregroundColor: Colors.white, 
          ),
        ),
        
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.brown, 
            side: const BorderSide(color: Colors.brown), 
          ),
        ),
        
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
          ),
          labelStyle: TextStyle(color: Colors.brown),
        ),
      ),
      home: page,
    );
  }
}