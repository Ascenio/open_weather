import 'package:flutter/material.dart';
import 'package:open_weather/core/presentation/widgets/breakpoint_builder.dart';

class ConstrainedByMobile extends StatelessWidget {
  const ConstrainedByMobile({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          Size.fromWidth(Breakpoint.mobile.minimumWidth),
        ),
        child: child,
      ),
    );
  }
}
