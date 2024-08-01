import 'package:flutter/material.dart';

import '../widgets/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 194, 123, 226),
                    Color.fromARGB(255, 76, 44, 116),
                    Color.fromARGB(255, 23, 16, 30)
                  ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const Spacer(flex: 10),
              Image.asset("assets/Screen_Shot_2024-01-03_at_7.14 1.png"),
              const Spacer(flex: 10),
              const Button(btnText: "Get Started"),
              Image.asset("assets/cat.png")
            ],
          ),
        ),
      ),
    );
  }
}
