import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/ui/kit/icons.dart';
import 'package:test_base_flutter/ui/kit/svg_button.dart';

class NavigationBackButton extends StatelessWidget {
  const NavigationBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgButton(
      onPressed: () {
        context.pop();
      },
      icon: TestBaseIcons.arrowBack,
    );
  }
}
