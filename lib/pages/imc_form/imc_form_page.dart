import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../core/extensions/extensions.dart';
import '../../core/models/models.dart';
import '../../services/imc_service/imc_service.dart';
import '../../services/imc_service/imc_service_impl.dart';
import '../imc_result/imc_result_page.dart';
import 'bloc/imc_form_bloc.dart';

class IMCFormPage extends StatelessWidget {
  final Person? person;
  const IMCFormPage({super.key, this.person});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<IMCService>(create: (_) => IMCServiceImpl()),
        BlocProvider(
          create: (context) => IMCFormBloc(
            imcService: context.read(),
            personRepository: context.read(),
            personDimensionsRepository: context.read(),
            initialPerson: person,
          ),
        ),
      ],
      child: _IMCFormView(person: person),
    );
  }
}

class _IMCFormView extends StatefulWidget {
  final Person? person;
  const _IMCFormView({this.person});

  @override
  State<_IMCFormView> createState() => _IMCFormViewState();
}

class _IMCFormViewState extends State<_IMCFormView> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final controller = context.read<IMCFormBloc>();

    return BlocListener<IMCFormBloc, IMCFormState>(
      listener: (context, state) {
        if (state.status == IMCFormStatus.success) {
          Navigator.pushReplacement(
            context,
            IMCResultPage(
              person: state.person,
              imcResult: state.imcResult!,
            ).route(),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: IMCAppBar(title: 'Calcular IMC'),
          body: ListView(
            padding: const EdgeInsets.all(32.0).copyWith(top: 0.0),
            children: [
              const Text('Nome (opcional)'),
              const SizedBox(height: 8.0),
              TextFormField(
                initialValue: controller.name,
                keyboardType: TextInputType.name,
                onChanged: (value) => controller.name = value,
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
                initialValue: controller.gender,
                onChanged: (value) => controller.gender = value,
              ),
              const SizedBox(height: 32.0),
              BlocBuilder<IMCFormBloc, IMCFormState>(
                buildWhen: (previous, current) =>
                    previous.weight != current.weight,
                builder: (context, state) {
                  return _Slider(
                    label: 'Massa (Kg)',
                    displayValue: '${state.weight} Kg',
                    value: state.weight,
                    min: 30.0,
                    max: 250.0,
                    steps: 0.5,
                    onChanged: (value) => controller.weight = value,
                  );
                },
              ),
              const SizedBox(height: 32.0),
              BlocBuilder<IMCFormBloc, IMCFormState>(
                buildWhen: (previous, current) =>
                    previous.height != current.height,
                builder: (context, state) {
                  return _Slider(
                    label: 'Altura (m)',
                    displayValue: '${state.height} m',
                    value: state.height,
                    min: 1.0,
                    max: 2.5,
                    steps: 0.01,
                    onChanged: (value) => controller.height = value,
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(32.0).copyWith(top: 8.0),
            child: _CalculateButton(
              onPressed: () async {
                context.read<IMCFormBloc>().calculateIMC();
              },
            ),
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

class _CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CalculateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final status =
        context.select<IMCFormBloc, IMCFormStatus>((bloc) => bloc.state.status);

    final isLoading = status == IMCFormStatus.loading;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : const Text('Calcular Meu IMC'),
    );
  }
}
