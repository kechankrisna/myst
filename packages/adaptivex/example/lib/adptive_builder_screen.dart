import 'package:adaptivex/adaptivex.dart';
import 'package:flutter/material.dart';

class AdaptiveBuilderScreen extends StatefulWidget {
  const AdaptiveBuilderScreen({Key? key}) : super(key: key);

  @override
  _AdaptiveBuilderScreenState createState() => _AdaptiveBuilderScreenState();
}

class _AdaptiveBuilderScreenState extends State<AdaptiveBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("using adaptive builder"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AdaptiveBuilder(
              xlBuilder: (_) => const Text("xlBuilder"),
              lgBuilder: (_) => const Text("lgBuilder"),
              mdBuilder: (_) => const Text("mdBuilder"),
              smBuilder: (_) => const Text("smBuilder"),

              /// xsBuilder: (_) => const Text("xsBuilder"),
              builder: (_) => const Text("xsBuilder"),
            ),
            CustomerAdpativeBuilder(
              builder: (_) => Text("data"),
              xl: Text("xl"),
            ),
          ],
        ),
      ),
    );
  }
}

/// custom
class CustomerAdpativeBuilder extends AdaptiveBuilder {
  final Widget? xl;
  final Widget? lg;
  final Widget? md;
  final Widget? sm;
  final Widget? xs;

  const CustomerAdpativeBuilder({
    Key? key,
    required Widget Function(BuildContext context) builder,
    this.xl,
    this.lg,
    this.md,
    this.sm,
    this.xs,
  }) : super(key: key, builder: builder);

  @override
  Widget Function(BuildContext context)? get xlBuilder =>
      (context) => xl ?? builder(context);
  @override
  Widget Function(BuildContext context)? get lgBuilder =>
      (context) => lg ?? builder(context);

  @override
  Widget Function(BuildContext context)? get mdBuilder =>
      (context) => md ?? builder(context);

  @override
  Widget Function(BuildContext context)? get smBuilder =>
      (context) => sm ?? builder(context);

  @override
  Widget Function(BuildContext context)? get xsBuilder =>
      (context) => xs ?? builder(context);
}
