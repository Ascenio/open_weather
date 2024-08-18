import 'package:flutter/material.dart';
import 'package:open_weather/core/presentation/widgets/breakpoint_builder.dart';

class ConstrainedByBreakpoint extends StatelessWidget {
  const ConstrainedByBreakpoint({
    required this.breakpoint,
    required this.child,
    super.key,
  });

  final Breakpoint breakpoint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          Size.fromWidth(breakpoint.minimumWidth),
        ),
        child: child,
      ),
    );
  }
}
