import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_base_flutter/data/model/game/game_type.dart';
import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';
import 'package:test_base_flutter/features/game/_root/bloc/root_game_bloc.dart';
import 'package:test_base_flutter/features/game/_root/bloc/root_game_event.dart';
import 'package:test_base_flutter/features/game/_root/bloc/root_game_state.dart';
import 'package:test_base_flutter/features/game/_root/representation/components/count_down_page.dart';
import 'package:test_base_flutter/features/game/_root/representation/components/question_page.dart';
import 'package:test_base_flutter/features/game/_root/representation/components/result_page.dart';
import 'package:test_base_flutter/ui/components/screen.dart';

class RootGameScreenProvider extends StatelessWidget {
  final int questionsCount;
  final int dictionaryId;
  final GameType gameType;

  const RootGameScreenProvider({
    required this.questionsCount,
    required this.dictionaryId,
    required this.gameType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RootGameBloc>(
      create: (context) => RootGameBloc(context.read(), context.read())
        ..add(StartRootGameEvent(
            questionsCount: questionsCount,
            dictionaryId: dictionaryId,
            gameType: gameType)),
      child: const RootGameScreen(),
    );
  }
}

class RootGameScreen extends StatefulWidget {
  const RootGameScreen({Key? key}) : super(key: key);

  @override
  State<RootGameScreen> createState() => _RootGameScreenState();
}

class _RootGameScreenState extends State<RootGameScreen> {
  final List<QuestionTerm> mistakenTerms = [];
  late Question question;
  bool inProgress = true;
  bool isGameEnded = false;
  int currentQuestion = 1;
  int questionCount = 1;

  Widget widgetToShow = const Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<RootGameBloc, RootGameState>(
      listener: (context, state) {
        setState(() {
          if (state is ProgressRootGameState) {
            widgetToShow = const Center(
              child: CircularProgressIndicator(),
            );
            inProgress = state.progress;
          }
          if (state is CountDownRootGameState) {
            widgetToShow = CountDownPage(state.time);
          }
          if (state is NewQuestionRootGameState) {
            mistakenTerms.clear();
            question = state.question;
            questionCount = state.questionCount;
            currentQuestion = state.currentQuestion;
          }
          if (state is MistakeRootGameState) {
            mistakenTerms.add(state.term);
          }
          if (state is NewQuestionRootGameState ||
              state is MistakeRootGameState) {
            widgetToShow = QuestionPage(
              mistakenTerms: mistakenTerms,
              onTermClicked: (term) {
                BlocProvider.of<RootGameBloc>(context).add(
                  AnswerQuestionRootGameEvent(term),
                );
              },
              question: question,
              currentQuestion: currentQuestion,
              questionCount: questionCount,
            );
          }
          if (state is EndedRootGameState) {
            widgetToShow = ResultPage(
              mistakes: state.mistakes,
              time: state.takenTime,
            );
            isGameEnded = true;
          } else {
            isGameEnded = false;
          }
        });
      },
      builder: (context, state) => WillPopScope(
        onWillPop: () async => isGameEnded,
        child: widgetToShow,
      ),
      showProgress: (state) => inProgress,
    );
  }
}
