import 'package:flutter/material.dart';

import '../core/models/models.dart';
import '../gen/assets.gen.dart';
import 'gender_card.dart';

class GenderSelect extends StatefulWidget {
  final ValueChanged<Gender> onChanged;
  const GenderSelect({super.key, required this.onChanged});

  @override
  State<GenderSelect> createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  Gender? _selected;

  void selectGender(Gender gender) {
    setState(() => _selected = gender);
    widget.onChanged(gender);
  }

  final _genders = <Map<String, dynamic>>[
    {'image': Assets.images.male, 'text': 'Masculino', 'value': Gender.male},
    {'image': Assets.images.female, 'text': 'Feminino', 'value': Gender.female},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _genders.map((gender) {
        final {
          'image': AssetGenImage image,
          'text': String text,
          'value': Gender value,
        } = gender;

        return Expanded(
          child: GenderCard(
            image: image.image(height: 48),
            text: text,
            isSelected: _selected == value,
            onPressed: () => selectGender(value),
          ),
        );
      }).toList(),
    );
  }
}
