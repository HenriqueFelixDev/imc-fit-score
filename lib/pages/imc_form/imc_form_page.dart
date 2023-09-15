import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../core/models/models.dart';
import '../../services/imc_service/imc_service_impl.dart';
import '../imc_result/imc_result_page.dart';

class IMCFormPage extends StatefulWidget {
  const IMCFormPage({super.key});

  @override
  State<IMCFormPage> createState() => _IMCFormPageState();
}

class _IMCFormPageState extends State<IMCFormPage> {
  String? name;
  Gender? gender;
  double height = 1.5;
  double weight = 30.0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              const IMCTitle(text: 'Calcular IMC'),
              const Text('Nome (opcional)'),
              const SizedBox(height: 8.0),
              TextField(
                keyboardType: TextInputType.name,
                onChanged: (value) => name = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: colors.surface),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              const Text('Gênero (opcional)'),
              const SizedBox(height: 8.0),
              GenderSelect(
                onChanged: (value) => gender = value,
              ),
              const SizedBox(height: 32.0),
              _Slider(
                label: 'Massa (Kg)',
                displayValue: '$weight Kg',
                value: weight,
                min: 30.0,
                max: 250.0,
                steps: 0.5,
                onChanged: (value) => setState(() => weight = value),
              ),
              const SizedBox(height: 32.0),
              _Slider(
                label: 'Altura (m)',
                displayValue: '$height m',
                value: height,
                min: 1.0,
                max: 2.5,
                steps: 0.01,
                onChanged: (value) => setState(() => height = value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0).copyWith(top: 8.0),
          child: ElevatedButton(
            onPressed: () {
              final person = Person(
                name: name,
                gender: gender,
                height: height,
                weight: weight,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) {
                  return IMCResultPage(
                    person: person,
                    imcService: IMCServiceImpl(),
                  );
                }),
              );
            },
            child: const Text('Calcular Meu IMC'),
          ),
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final String label;
  final String displayValue;
  final double value;
  final double min;
  final double max;
  final double steps;
  final ValueChanged<double> onChanged;

  const _Slider({
    required this.label,
    required this.displayValue,
    required this.value,
    required this.min,
    required this.max,
    required this.steps,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final divisions = ((max - min) / steps).round();

    return Column(
      children: [
        Text(label),
        Slider.adaptive(
          label: displayValue,
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: (value) {
            final formattedValue = value.toStringAsFixed(2);
            onChanged(double.parse(formattedValue));
          },
        ),
        Text(
          displayValue,
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
