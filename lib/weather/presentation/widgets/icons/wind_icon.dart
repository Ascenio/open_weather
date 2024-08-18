import 'dart:math';

import 'package:flutter/material.dart';

class WindIcon extends StatelessWidget {
  const WindIcon({
    required this.degrees,
    super.key,
  });

  final double degrees;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi / 4 - pi / 2 - degrees * (pi / 180),
      child: const Icon(Icons.near_me_outlined),
    );
  }
}
