import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class AdaptiveContext extends StatelessWidget {
  /// `xlBuilder`
  ///
  /// this widget will render on xlarge width
  final Widget Function(BuildContext context)? xlBuilder;

  /// `lgBuilder`
  ///
  /// this widget will render on large width
  final Widget Function(BuildContext context)? lgBuilder;

  /// `mdBuilder`
  ///
  /// this widget will render on medium width
  final Widget Function(BuildContext context)? mdBuilder;

  /// `smBuilder`
  ///
  /// this widget will render on small width
  final Widget Function(BuildContext context)? smBuilder;

  /// `xsBuilder`
  ///
  /// this widget will render on xsmall width
  final Widget Function(BuildContext context)? xsBuilder;

  /// `builder`
  ///
  /// this is required as the default rendering
  final Widget Function(BuildContext context) builder;

  const AdaptiveContext({
    Key? key,
    this.xlBuilder,
    this.lgBuilder,
    this.mdBuilder,
    this.smBuilder,
    this.xsBuilder,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    switch (context.deviceSize) {
      case DeviceSize.xl:
        return xlBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.lg:
        return lgBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.md:
        return mdBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.sm:
        return smBuilder?.call(context) ?? builder.call(context);
      case DeviceSize.xs:
        return xsBuilder?.call(context) ?? builder.call(context);
      default:
        return builder.call(context);
    }
  }
}
