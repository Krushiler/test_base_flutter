import 'package:flutter/material.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';

class QuestionPage extends StatelessWidget {
  final Question question;
  final List<Term> mistakenTerms;
  final void Function(Term) onTermClicked;

  const QuestionPage({
    Key? key,
    required this.mistakenTerms,
    required this.onTermClicked,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            question.rightTerm.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Gap.xxl,
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => ElevatedButton(
              onPressed: _isMistaken(question.terms[index])
                  ? null
                  : () {
                      onTermClicked.call(question.terms[index]);
                    },
              child: Text(question.terms[index].name)),
          separatorBuilder: (context, position) => Gap.md,
          itemCount: question.terms.length,
        ),
      ],
    );
  }

  bool _isMistaken(Term term) {
    return mistakenTerms.contains(term);
  }
}
