import 'package:flutter/material.dart';

/// Custom page transition that provides PageView-style horizontal slide
/// animations for bottom navigation routes (home and favorites).
class PageViewTransitionPage extends Page<void> {
  const PageViewTransitionPage({
    required this.child,
    required this.routeIndex,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final int routeIndex;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _SlideTransitionWidget(
          animation: animation,
          routeIndex: routeIndex,
          child: child,
        );
      },
    );
  }
}

/// Page transition that tracks navigation direction internally
class StatefulPageViewTransitionPage extends Page<void> {
  const StatefulPageViewTransitionPage({
    required this.child,
    required this.routeIndex,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final int routeIndex;

  @override
  Route<void> createRoute(BuildContext context) {
    return PageRouteBuilder<void>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _SlideTransitionWidget(
          animation: animation,
          routeIndex: routeIndex,
          child: child,
        );
      },
    );
  }
}

/// StatefulWidget for slide transition animation that tracks navigation
/// direction
class _SlideTransitionWidget extends StatefulWidget {
  const _SlideTransitionWidget({
    required this.animation,
    required this.routeIndex,
    required this.child,
  });

  final Animation<double> animation;
  final int routeIndex;
  final Widget child;

  @override
  State<_SlideTransitionWidget> createState() => _SlideTransitionWidgetState();
}

class _SlideTransitionWidgetState extends State<_SlideTransitionWidget> {
  static int? _lastRouteIndex;
  int? _previousRouteIndex;

  @override
  void initState() {
    super.initState();
    _previousRouteIndex = _lastRouteIndex;
    _lastRouteIndex = widget.routeIndex;
  }

  @override
  Widget build(BuildContext context) {
    final slideDirection = _getSlideDirection();

    return SlideTransition(
      position:
          Tween<Offset>(
            begin: slideDirection,
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: widget.animation,
              curve: Curves.easeInOut,
            ),
          ),
      child: widget.child,
    );
  }

  Offset _getSlideDirection() {
    if (_previousRouteIndex != null) {
      if (widget.routeIndex > _previousRouteIndex!) {
        return const Offset(1, 0);
      } else if (widget.routeIndex < _previousRouteIndex!) {
        return const Offset(-1, 0);
      } else {
        return Offset.zero;
      }
    }

    return const Offset(1, 0);
  }
}
