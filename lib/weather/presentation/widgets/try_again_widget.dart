import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({
    required this.error,
    required this.tryAgain,
    super.key,
  });

  final String error;
  final VoidCallback tryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.refresh),
              iconAlignment: IconAlignment.end,
              label: const Text('Try again'),
              onPressed: tryAgain,
            ),
          )
        ],
      ),
    );
  }
}
