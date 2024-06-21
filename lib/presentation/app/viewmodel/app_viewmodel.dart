import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temp_house/presentation/base/base_cubit.dart';

class AppViewModel extends BaseCubit {
  static AppViewModel get(context) => BlocProvider.of(context);

  @override
  void start() {}
}
