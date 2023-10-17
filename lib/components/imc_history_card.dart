import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/models/person_dimensions.dart';

class IMCHistoryCard extends StatelessWidget {
  final PersonDimensions dimensions;
  const IMCHistoryCard({super.key, required this.dimensions});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text('${dimensions.height}m - ${dimensions.weight}Kg'),
      trailing: Text(DateFormat.yMd().add_Hm().format(dimensions.date)),
    );
  }
}
