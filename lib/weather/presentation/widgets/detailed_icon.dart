import 'package:flutter/material.dart';

class IconListItem extends StatelessWidget {
  const IconListItem({required this.icon, required this.label, super.key});

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
