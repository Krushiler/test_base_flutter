import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';

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
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Mistakes: $mistakes', style: Theme.of(context).textTheme.h3?.bold,),
              Gap.xxl,
              Text('${time.toStringAsPrecision(2)} seconds', style: Theme.of(context).textTheme.h3?.bold),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 160,
                child: OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Back'),
                ),
              ),
              Gap.xxl,
            ],
          )
        ],
      ),
    );
  }
}
