import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';

class ResultPage extends StatelessWidget {
  final int mistakes;
  final double time;

  const ResultPage({
    Key? key,
    required this.mistakes,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Mistakes: $mistakes'),
            Gap.xxl,
            Text('${time.toStringAsPrecision(2)} seconds'),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Back'),
            )
          ],
        ),
      ],
    );
  }
}
