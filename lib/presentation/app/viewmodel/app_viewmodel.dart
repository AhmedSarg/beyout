import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';

class AppViewModel extends BaseCubit {
  static AppViewModel get(context) => BlocProvider.of(context);

  StreamController<int> testStream = StreamController();

  @override
  void start() {
    // int i = 1;
    // testStream.stream.listen(
    //   (event) {
    //     print(event);
    //   },
    // );
    // Timer.periodic(
    //   const Duration(seconds: 1),
    //   (timer) {
    //     testStream.add(i);
    //     i++;
    //   },
    // );
  }
}
