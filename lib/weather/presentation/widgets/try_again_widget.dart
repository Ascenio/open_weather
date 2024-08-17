import 'package:flutter/material.dart';
import 'package:open_weather/core/presentation/widgets/wide_button.dart';

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
          WideButton(
            icon: Icons.refresh,
            label: 'Try again',
            onPressed: tryAgain,
          )
        ],
      ),
    );
  }
}
