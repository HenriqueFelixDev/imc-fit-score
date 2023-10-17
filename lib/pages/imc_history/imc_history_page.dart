import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/person_dimensions/person_dimensions_repository.dart';
import '../../components/components.dart';
import '../../core/models/models.dart';

class IMCHistoryPage extends StatelessWidget {
  final Person person;
  const IMCHistoryPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IMCAppBar(title: 'Histórico de IMC\'s'),
      body: FutureBuilder(
          future: context
              .read<PersonDimensionsRepository>()
              .getAllByPersonId(person.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final dimensions = snapshot.data ?? [];

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: dimensions.length,
              itemBuilder: (context, index) {
                return IMCHistoryCard(dimensions: dimensions[index]);
              },
            );
          }),
    );
  }
}
