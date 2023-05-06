enum GameType { description, translation }

extension GameTypeExtension on GameType {
  String get name {
    switch (this) {
      case GameType.translation:
        return 'Translation';
      case GameType.description:
        return 'Description';
    }
  }
}

extension GameTypeStringExtension on String {
  GameType get gameType {
    switch(this) {
      case 'Translation':
        return GameType.translation;
      case 'Description':
        return GameType.description;
      default: return GameType.translation;
    }
  }
}