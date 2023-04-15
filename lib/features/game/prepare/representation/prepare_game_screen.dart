import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_base_flutter/data/model/dictionary/dictionary.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_bloc.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_event.dart';
import 'package:test_base_flutter/features/game/prepare/bloc/prepare_game_state.dart';
import 'package:test_base_flutter/features/home/home_routing.dart';
import 'package:test_base_flutter/ui/components/screen.dart';
import 'package:test_base_flutter/ui/kit/gap.dart';
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<Dictionary>(
                    value: selectedDictionary,
                    items: dictionaries
                        .map(
                          (e) => DropdownMenuItem<Dictionary>(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (dictionary) {
                      setState(() {
                        selectedDictionary = dictionary;
                      });
                    }),
                Gap.xxl,
                Gap.xxl,
                ElevatedButton(
                  onPressed: selectedDictionary != null
                      ? () {
                          context.pushNamed(
                            HomeRoute.practiceGame,
                            queryParams: {
                              HomeParams.questionsCount: 10.toString(),
                              HomeParams.dictionaryId:
                                  selectedDictionary!.id.toString(),
                            },
                          );
                        }
                      : null,
                  child: const Text('Start'),
                ),
              ],
            ),
          ],
        );
      },
      showProgress: (state) => inProgress,
    );
  }
}
