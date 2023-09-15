import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../core/models/models.dart';
import '../../gen/colors.gen.dart';
import '../../services/imc_service/imc_service.dart';

class IMCResultPage extends StatelessWidget {
  final Person person;
  final IMCService imcService;
  const IMCResultPage({super.key, required this.person, required this.imcService});

  String getStatusMessage(IMCStatus status) {
    return switch(status) {
      IMCStatus.veryUnderweight => 'Muito Abaixo do Peso',
      IMCStatus.underweight => 'Abaixo do Peso',
      IMCStatus.normal => 'Normal',
      IMCStatus.overweight => 'Sobrepeso',
      IMCStatus.obeseClass1 => 'Obesidade Grau I',
      IMCStatus.obeseClass2 => 'Obesidade Grau II',
      IMCStatus.obeseClass3 => 'Obesidade Grau III',
    };
  }
  
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final IMCResult(:imc, :status) = imcService.getIMC(person);

    return SafeArea(
      child: Scaffold(
        body: Padding(
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
              Row(
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
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Text(
                      imc.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getStatusMessage(status),
                      style: const TextStyle(color: ColorName.textOpaque)
                    ),
                  ],
                ),
              ),
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
