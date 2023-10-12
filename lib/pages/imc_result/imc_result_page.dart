import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../components/imc_result_card.dart';
import '../../core/models/models.dart';
import '../../services/imc_service/imc_service.dart';

class IMCResultPage extends StatelessWidget {
  final Person person;
  final IMCService imcService;
  const IMCResultPage({
    super.key,
    required this.person,
    required this.imcService,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final imc = imcService.getIMC(person);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const IMCTitle(text: 'IMC'),
                    Text(
                      person.name ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _IMCCalculation(person: person),
                    IMCResultCard(imc: imc),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleButton.surface(
                          onPressed: () {},
                          child: const Icon(Icons.share_rounded),
                        ),
                        CircleButton.surface(
                          onPressed: () {},
                          child: const Icon(Icons.add_photo_alternate),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0).copyWith(top: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surface,
              foregroundColor: colors.onSurface,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar'),
          ),
        ),
      ),
    );
  }
}

class _IMCCalculation extends StatelessWidget {
  final Person person;
  const _IMCCalculation({required this.person});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'IMC =',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(person.weight.toStringAsFixed(1)),
            const SizedBox(
              height: 10.0,
              width: 80.0,
              child: Divider(),
            ),
            Text('${person.height} x ${person.height}'),
          ],
        )
      ],
    );
  }
}
