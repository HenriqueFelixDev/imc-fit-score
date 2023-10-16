import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/storage/settings_storage.dart';
import 'pages/imc_form/imc_form_page.dart';
import 'pages/onboarding/onboarding_page.dart';
import 'styles/theme.dart';

class AppWidget extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const AppWidget({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: sharedPreferences),
        Provider(
          create: (context) => SettingsStorage(preferences: context.read()),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'IMC FitScore',
          theme: darkTheme,
          home: context.read<SettingsStorage>().hideOnboarding
              ? const IMCFormPage()
              : const OnboardingPage(),
        );
      },
    );
  }
}
