import 'package:flutter/material.dart';

import '../core/extensions/extensions.dart';
import '../core/models/models.dart';
import '../gen/assets.gen.dart';
import '../pages/imc_form/imc_form_page.dart';
import '../pages/imc_history/imc_history_page.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard({super.key, required this.person});

  Future<void> _showOptionsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    person.name ?? 'Sem Nome',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Adicionar IMC'),
                  onTap: () {
                    Navigator.pop(context); // Closes Bottom Sheet
                    Navigator.push(
                      context,
                      IMCFormPage(person: person).route(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.pie_chart),
                  title: const Text('Visualizar Histórico de IMC\'s'),
                  onTap: () {
                    Navigator.pop(context); // Closes Bottom Sheet
                    Navigator.push(
                      context,
                      IMCHistoryPage(person: person).route(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Excluir Usuário'),
                  onTap: () {
                    // TODO: implement delete person
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatar = person.gender == Gender.female
        ? Assets.images.female
        : Assets.images.male;

    return InkWell(
      onTap: () {
        _showOptionsBottomSheet(context);
        // Navigator.push(context, IMCHistoryPage(person: person).route());
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
