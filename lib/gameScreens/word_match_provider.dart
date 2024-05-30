import 'dart:math';
import 'package:flutter/material.dart';

class WordMatchProvider extends ChangeNotifier {
  Map<String, String> wordPairs = {
    'Leben': 'To live',
    'Akzeptieren': 'To accept',
    'Wählen': 'To choose',
    'Arbeiten': 'To work',
  };

  late List<String> shuffledKeys;
  late List<String> shuffledValues;
  String? selectedLeftWord;
  Map<String, Color> wordColors = {};
  int resetCounter = 0;

  WordMatchProvider() {
    _shuffleWords();
  }

  void _shuffleWords() {
    shuffledKeys = wordPairs.keys.toList()..shuffle();
    shuffledValues = wordPairs.values.toList()..shuffle();
  }

  void selectLeftWord(String word) {
    selectedLeftWord = word;
    notifyListeners();
  }

  void selectRightWord(String pair) {
    if (selectedLeftWord != null) {
      if (wordPairs[selectedLeftWord] == pair) {
        wordColors[selectedLeftWord!] = Colors.green;
        wordColors[pair] = Colors.green;
      } else {
        wordColors[selectedLeftWord!] = Colors.red;
        wordColors[pair] = Colors.red;
      }
      selectedLeftWord = null;
      notifyListeners();
    }
  }

  bool areAllPairsSelected() {
    return wordColors.length == wordPairs.length * 2;
  }

  void resetPairs() {
    wordColors.clear();
    _shuffleWords();
    notifyListeners();
  }

  void incrementResetCounter() {
    resetCounter++;
    notifyListeners();
  }
}
