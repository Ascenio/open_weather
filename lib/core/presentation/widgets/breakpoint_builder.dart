import 'package:flutter/material.dart';

enum Breakpoint {
  desktop(1024),
  tablet(768),
  mobile(480);

  const Breakpoint(this.minimumWidth);

  final double minimumWidth;
}

class BreakpointBuilder extends StatelessWidget {
  const BreakpointBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(Breakpoint breakpoint) builder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Breakpoint breakpoint;
    if (size.width < Breakpoint.tablet.minimumWidth) {
      breakpoint = Breakpoint.mobile;
    } else if (size.width < Breakpoint.desktop.minimumWidth) {
      breakpoint = Breakpoint.tablet;
    } else {
      breakpoint = Breakpoint.desktop;
    }
    return builder(breakpoint);
  }
}
