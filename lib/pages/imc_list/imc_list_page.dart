import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../core/extensions/extensions.dart';
import '../imc_form/imc_form_page.dart';
import 'bloc/imc_list_bloc.dart';

class IMCListPage extends StatelessWidget {
  const IMCListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IMCListBloc(personRepository: context.read()),
      child: const _IMCListView(),
    );
  }
}

class _IMCListView extends StatelessWidget {
  const _IMCListView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<IMCListBloc>();
    final IMCListState(:status, :people) = controller.state;

    if (status == IMCListStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: IMCAppBar(title: 'IMC\'s'),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: people.length,
        itemBuilder: (_, index) => PersonCard(person: people[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, const IMCFormPage().route()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
