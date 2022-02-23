import 'package:flutter/material.dart';

class AdaptivePopupRoute<T> extends PopupRoute<T> {
  /// `contentWidth` represent the popup width or max screen width as default
  final double? contentWidth;

  /// `contentHeight` represent the popup height or max screen height as default
  final double? contentHeight;

  /// `barrierDismissible` overlay barrier dimissable guester
  @override
  final bool barrierDismissible;

  /// `barrierColor` overlay barrier color
  @override
  final Color barrierColor;

  /// `duration` popup transition duration
  final Duration duration;

  /// `builder` aliase type of Widget Function(BuildContext) builder
  final WidgetBuilder builder;

  /// `top` the position of popup index from top
  final double? top;

  /// `bottom` the position of popup index from bottom
  final double? bottom;

  /// `left` the position of popup index from left
  final double? left;

  /// `right` the position of popup index from right
  final double? right;

  /// `AdaptivePopupRoute`
  ///
  /// use to show/hide popup route in an adaptive way
  ///
  /// Example:
  /// ```dart
  /// Navigator.of(context).push(
  ///   AdaptivePopupRoute(
  ///     builder: (_) => build,
  ///     settings: null,
  ///     top: position.top,
  ///     right: position.right,
  ///     bottom: position.bottom,
  ///     left: position.left,
  ///     contentHeight: dropDownHeight,
  ///     contentWidth: dropDownWidth,
  ///   ),
  /// );
  /// ```
  AdaptivePopupRoute({
    required this.builder,
    RouteSettings? settings,
    this.contentWidth,
    this.contentHeight,
    this.barrierColor = Colors.transparent,
    this.barrierDismissible = true,
    this.duration = const Duration(milliseconds: 100),
    this.top,
    this.bottom,
    this.left,
    this.right,
  }) : super(settings: settings);

  @override
  Duration get transitionDuration => duration;

  @override
  String get barrierLabel => "back";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Stack(
      children: [
        Positioned(
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          width: contentWidth ?? MediaQuery.of(context).size.width,
          height: contentHeight ?? MediaQuery.of(context).size.height,
          child: FadeTransition(
            opacity: animation,
            child: builder(context),
          ),
        ),
      ],
    );
  }
}
