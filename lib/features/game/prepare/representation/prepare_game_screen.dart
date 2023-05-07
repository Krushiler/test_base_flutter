import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/data/model/game/game_type.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_bloc.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_event.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_state.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';
import 'package:test_base_flutter/util/snackbar_util.dart';

class PrepareGameScreenProvider extends StatelessWidget {
  const PrepareGameScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrepareGameBloc>(
      create: (context) => PrepareGameBloc(context.read())
        ..add(
          LoadPrepareGameEvent(),
        ),
      child: const PrepareGameScreen(),
    );
  }
}

class PrepareGameScreen extends StatefulWidget {
  const PrepareGameScreen({Key? key}) : super(key: key);

  @override
  State<PrepareGameScreen> createState() => _PrepareGameScreenState();
}

class _PrepareGameScreenState extends State<PrepareGameScreen> {
  bool inProgress = true;
  List<Dictionary> dictionaries = [];
  Dictionary? selectedDictionary;
  final gameTypes = GameType.values;
  late GameType selectedGameType;

  final countController = TextEditingController(text: 10.toString());

  @override
  void initState() {
    super.initState();
    selectedGameType = gameTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenConsumer<PrepareGameBloc, PrepareGameState>(
      listener: (context, state) {
        setState(() {
          if (state is ProgressPrepareGameState) {
            inProgress = state.progress;
          }
          if (state is LoadedPrepareGameState) {
            dictionaries = state.dictionaries;
            selectedDictionary = dictionaries.first;
          }
          if (state is FailurePrepareGameState) {
            context.showSnackBar(state.message);
          }
        });
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap.xxl,
                Text(
                  'Dictionary',
                  style: Theme.of(context).textTheme.h3?.bold,
                ),
                Gap.md,
                if (selectedDictionary != null)
                  OutlinedButton(
                    onPressed: () async {
                      final result =
                          await context.pushNamed(HomeRoute.dictionarySelect);
                      if (result != null && result is Dictionary) {
                        setState(() {
                          selectedDictionary = result;
                        });
                      }
                    },
                    child: Text(selectedDictionary!.name),
                  ),
                Gap.xxl,
                Text(
                  'Questions count',
                  style: Theme.of(context).textTheme.h3?.bold,
                ),
                Gap.md,
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    controller: countController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                ),
                Gap.xxl,
                Text(
                  'Game type',
                  style: Theme.of(context).textTheme.h3?.bold,
                ),
                Gap.md,
                DropdownButton<GameType>(
                  value: selectedGameType,
                  items: gameTypes
                      .map(
                        (e) => DropdownMenuItem<GameType>(
                          value: e,
                          child: Text(e.name),
                        ),
                      )
                      .toList(),
                  onChanged: (type) {
                    setState(() {
                      if (type != null) {
                        selectedGameType = type;
                      }
                    });
                  },
                ),
                Gap.xxl,
                SizedBox(
                  width: 240,
                  child: ElevatedButton(
                    onPressed: selectedDictionary != null &&
                            int.tryParse(countController.text) != null &&
                            int.parse(countController.text) <=
                                selectedDictionary!.termsCount &&
                            int.parse(countController.text) > 0
                        ? () {
                            context.pushNamed(
                              HomeRoute.practiceGame,
                              queryParams: {
                                HomeParams.questionsCount: countController.text,
                                HomeParams.dictionaryId:
                                    selectedDictionary!.id.toString(),
                                HomeParams.gameType: selectedGameType.name
                              },
                            );
                          }
                        : null,
                    child: const Text('Start'),
                  ),
                ),
                Gap.xxl,
              ],
            ),
          ),
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
