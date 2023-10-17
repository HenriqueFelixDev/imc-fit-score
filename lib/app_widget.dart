import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/storage/settings_storage.dart';
import 'pages/imc_list/imc_list_page.dart';
import 'pages/onboarding/onboarding_page.dart';
import 'repositories/person/person_repository.dart';
import 'repositories/person/person_repository_impl.dart';
import 'repositories/person_dimensions/person_dimensions_repository.dart';
import 'repositories/person_dimensions/person_dimensions_repository_impl.dart';
import 'styles/theme.dart';

class AppWidget extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const AppWidget({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<PersonRepository>(
          create: (_) => PersonRepositoryImpl(),
        ),
        RepositoryProvider<PersonDimensionsRepository>(
          create: (_) => PersonDimensionsRepositoryImpl(),
        ),
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
              ? const IMCListPage()
              : const OnboardingPage(),
        );
      },
    );
  }
}
