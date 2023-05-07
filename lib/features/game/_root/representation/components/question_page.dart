import 'package:flutter/material.dart';
import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';
import 'package:test_base_flutter/ui/dimens.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';

class QuestionPage extends StatelessWidget {
  final Question question;
  final List<QuestionTerm> mistakenTerms;
  final void Function(QuestionTerm) onTermClicked;
  final int currentQuestion;
  final int questionCount;

  const QuestionPage({
    Key? key,
    required this.mistakenTerms,
    required this.onTermClicked,
    required this.question,
    required this.currentQuestion,
    required this.questionCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: Dimens.xxl),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.sm),
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: (currentQuestion + 1) / (questionCount - 1),
              ),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: Dimens.md,
                backgroundColor: AppColors.gray.shade200,
              ),
            ),
          ),
          Gap.md,
          Expanded(
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
                      question.rightTerm.answer,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap.xxl,
          Expanded(
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
        ],
      ),
    );
  }

  bool _isMistaken(QuestionTerm term) {
    return mistakenTerms.contains(term);
  }
}
