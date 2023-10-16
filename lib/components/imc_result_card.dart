import 'package:flutter/material.dart';

import '../core/models/models.dart';
import '../gen/colors.gen.dart';

class IMCResultCard extends StatelessWidget {
  final IMCResult imc;
  const IMCResultCard({super.key, required this.imc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            imc.imc.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            imc.status.getMessage(),
            style: const TextStyle(color: ColorName.textOpaque),
          ),
        ],
      ),
    );
  }
}
