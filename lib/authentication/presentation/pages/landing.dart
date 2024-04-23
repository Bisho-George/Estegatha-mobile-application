import 'package:estegatha/components/buttons.dart';
import 'package:flutter/material.dart';

class LandingIntro extends StatelessWidget {
  const LandingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF03045E),
              Color(0xFF4F8EB9),
              Color(0xFFF3F7FA)
            ],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomElevatedButton(
                labelText: "Get Started",
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}
