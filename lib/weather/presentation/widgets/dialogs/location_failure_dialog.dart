import 'package:flutter/material.dart';
import 'package:open_weather/weather/domain/failures/location_failure.dart';
import 'package:open_weather/weather/presentation/widgets/failure_mappers.dart';

Future<void> showLocationFailureDialog({
  required BuildContext context,
  required LocationFailure failure,
}) async {
  final title = locationFailureToString(failure);
  await showAdaptiveDialog(
    context: context,
    builder: (_) => AlertDialog.adaptive(
      title: Text(title),
      content: Text(
        switch (failure) {
          LocationFailure.gpsDisabled => 'Try to enable it and try again.',
          LocationFailure.denied => 'Please, try again and accept it.',
          LocationFailure.deniedForever =>
            'Please, go to your settings and authorize the location permission',
          LocationFailure.unknown =>
            'It seems your device has no GPS capabilities',
        },
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
