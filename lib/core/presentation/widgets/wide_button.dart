import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.fill = true,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fill ? double.infinity : null,
      child: FilledButton.icon(
        icon: Icon(icon),
        iconAlignment: IconAlignment.end,
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
