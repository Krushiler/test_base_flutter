import 'dart:async';
import 'dart:math';

import 'package:test_base_flutter/data/model/_exception/user_exception.dart';
import 'package:test_base_flutter/data/model/terms/term.dart';
import 'package:test_base_flutter/data/model/game/game_state.dart';
import 'package:test_base_flutter/data/model/game/game_type.dart';
import 'package:test_base_flutter/data/model/game/question.dart';
import 'package:test_base_flutter/data/model/game/question_term.dart';
import 'package:test_base_flutter/repository/interfaces/dictonary_repository.dart';

class PracticeGameLogic {
  final _stateStreamController = StreamController<GameState>();

  get state => _stateStreamController.stream;

  double _takenTime = 0;
  int _countDownTime = 0;

  Timer? _timer;
  Timer? _countDownTimer;

  late int _questionsCount;
  late int _dictionaryId;
  late DictionaryRepository _dictionaryRepository;
  late GameType _gameType;

  setup(
      {required int questionsCount,
      required int dictionaryId,
      required DictionaryRepository dictionaryRepository,
      required GameType gameType}) {
    _questionsCount = questionsCount;
    _dictionaryId = dictionaryId;
    _dictionaryRepository = dictionaryRepository;
    _gameType = gameType;
  }

  final List<Question> _questions = [];

  int _currentQuestion = 0;
  int _userMistakes = 0;

  _startGame() async {
    _startGameTimer();
    _emitQuestion();
  }

  _startGameTimer() {
    _timer?.cancel();
    _takenTime = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _takenTime += 0.1;
    });
  }

  _startCountDownTimer() async {
    _countDownTimer?.cancel();
    _countDownTime = 3;

    _questions.clear();
    _questions.addAll(await _createQuestions());

    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _stateStreamController.add(CountDownGameState(_countDownTime));
      if (_countDownTime == 0) {
        _startGame();
        _countDownTimer?.cancel();
      }
      _countDownTime -= 1;
    });
  }

  Future<List<Question>> _createQuestions() async {
    final List<Question> questions = [];
    final termsResult = await _dictionaryRepository.getTerms(_dictionaryId);
    final List<Term> terms = [];
    termsResult.fold(
        (l) => throw UserException(l.message), (r) => terms.addAll(r.terms));
    terms.shuffle();
    final takenTerms = terms.take(_questionsCount);

    for (final element in takenTerms) {
      final List<Term> names = [];
      names.add(element);
      names.add(_getRandomTerm(terms, names));
      names.add(_getRandomTerm(terms, names));
      names.shuffle();
      questions.add(
        Question(
          names.map((e) => toQuestionTerm(e)).toList(),
          toQuestionTerm(element),
        ),
      );
    }
    questions.shuffle();
    return questions;
  }

  _getRandomTerm(List<Term> terms, List<Term> takenTerms) {
    Term? found;
    do {
      found = terms[Random().nextInt(terms.length)];
    } while (takenTerms.contains(found));
    return found;
  }

  _emitQuestion() {
    _stateStreamController.add(
      NewQuestionGameState(
        _questions[_currentQuestion],
        questionCount: _questionsCount,
        currentQuestion: _currentQuestion,
      ),
    );
  }

  void startGame() {
    _startCountDownTimer();
  }

  void giveAnswer(QuestionTerm term) {
    if (term.termId == _questions[_currentQuestion].rightTerm.termId) {
      _currentQuestion++;
      if (_currentQuestion < _questionsCount - 1) {
        _emitQuestion();
      } else {
        _stateStreamController.add(
          EndedGameState(
            mistakes: _userMistakes,
            time: _takenTime,
          ),
        );
        _timer?.cancel();
      }
    } else {
      _userMistakes++;
      _stateStreamController.add(MistakeGameState(term));
    }
  }

  QuestionTerm toQuestionTerm(Term term) {
    if (_gameType == GameType.translation) {
      return QuestionTerm(
        termId: term.id,
        name: term.name,
        answer: term.translation,
      );
    } else {
      return QuestionTerm(
        termId: term.id,
        name: term.name,
        answer: term.description,
      );
    }
  }
}
