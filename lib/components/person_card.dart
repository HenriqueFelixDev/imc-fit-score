import 'package:flutter/material.dart';

import '../core/extensions/extensions.dart';
import '../core/models/models.dart';
import '../gen/assets.gen.dart';
import '../pages/imc_form/imc_form_page.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final avatar = person.gender == Gender.female
        ? Assets.images.female
        : Assets.images.male;

    return InkWell(
      onTap: () {
        Navigator.push(context, IMCFormPage(person: person).route());
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            avatar.image(width: 48.0, height: 48.0),
            Text(person.name ?? 'Sem Nome'),
          ],
        ),
      ),
    );
  }
}
