import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: Icon(icon),
        iconAlignment: IconAlignment.end,
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
