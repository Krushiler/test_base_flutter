import 'package:flutter/material.dart';
import 'package:test_base_flutter/data/model/dictionary/term.dart';
import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/ui/dimens.dart';
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
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: Dimens.xxl),
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.md),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(
                        Dimens.sm,
                      ),
                    ),
                    child: Text(
                      question.rightTerm.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap.xxl,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }

  bool _isMistaken(Term term) {
    return mistakenTerms.contains(term);
  }
}