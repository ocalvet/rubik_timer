import 'dart:math';

const List<String> MOVE_TYPES = ["R", "L", "U", "D", "B", "F"];
const List<String> MOVE_TYPES_OPTIONS = ["", "'", "2"];

List<String> scrambleRubikMoves(int totalMoves) {
  List<String> result = List<String>();
  int randTypeIdx = 0;
  int randTypeOptionIdx = 0;
  String move;
  Random rnd = Random();
  for (int i = 0; i < totalMoves; i++) {
    do {
      randTypeIdx = rnd.nextInt(MOVE_TYPES.length);
      randTypeOptionIdx = rnd.nextInt(MOVE_TYPES_OPTIONS.length);
      move = MOVE_TYPES[randTypeIdx] + MOVE_TYPES_OPTIONS[randTypeOptionIdx];
    } while (i > 0 && move[0].compareTo(result[i - 1][0]) == 0);
    result.add(move);
  }
  return result;
}
