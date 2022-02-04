import 'dart:math';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'number_collector_state.dart';

class NumberCollectorCubit extends HydratedCubit<NumberCollectorState> {
  NumberCollectorCubit() : super(const NumberCollectorState(numbers: {0}));

  void addRandomNumber() {
    Set<int> numbers = {...state.numbers, Random().nextInt(100)};
    emit(NumberCollectorState(numbers: numbers));
  }

  @override
  NumberCollectorState? fromJson(Map<String, dynamic> json) {
    return NumberCollectorState(numbers: json['numbers']);
  }

  @override
  Map<String, dynamic>? toJson(NumberCollectorState state) {
    return {
      'numbers': state.numbers,
    };
  }
}
