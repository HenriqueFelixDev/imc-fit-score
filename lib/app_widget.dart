import 'package:flutter/material.dart';

import 'pages/onboarding/onboarding_page.dart';
import 'styles/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC FitScore',
      theme: darkTheme,
      home: const OnboardingPage(),
    );
  }
}
