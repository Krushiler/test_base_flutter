import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/ui/components/no_glow_scroll_behavior.dart';
import 'package:test_base_flutter/ui/dimens.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);
typedef ProgressBuilder<S> = bool Function(S state);
typedef ErrorBuilder<S> = bool Function(S state);

class ScreenConsumer<Bloc extends StateStreamableSource<State>, State>
    extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final BlocWidgetBuilder<State> builder;
  final BlocBuilderCondition<State>? buildWhen;

  final ProgressBuilder<State>? showProgress;

  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final EdgeInsets padding;
  final BlocWidgetListener<State>? listener;
  final BlocListenerCondition<State>? listenWhen;

  const ScreenConsumer({
    required this.builder,
    this.scaffoldKey,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.all(Dimens.md),
    this.showProgress,
    this.buildWhen,
    this.listener,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(context) {
    return BlocConsumer<Bloc, State>(
        listener: listener ?? (context, state) {},
        listenWhen: listenWhen ?? (_, __) => true,
        buildWhen: buildWhen ?? (_, __) => true,
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: appBar,
            drawer: drawer,
            bottomNavigationBar: bottomNavigationBar,
            body: SafeArea(
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: NoGlowScrollBehavior(),
                    child: Padding(
                      padding: padding,
                      child: builder.call(context, state),
                    ),
                  ),
                  if (showProgress?.call(state) ?? false)
                    Column(
                      children: const [Spacer(), LinearProgressIndicator()],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
