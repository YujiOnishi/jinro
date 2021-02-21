import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/providers/game.dart';

final gameProvider = StateNotifierProvider((_) => Game());