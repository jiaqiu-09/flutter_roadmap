import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'app_env_state.dart';

class AppEnvCubit extends Cubit<AppEnvState> {
  AppEnvCubit() : super(AppEnvInitial());

  loadConfig() async {
    try {
      await dotenv.load(fileName: '.env');
      emit(AppEnvLoadSuccess(config: dotenv.env));
    } catch (_) {
      emit(AppEnvLoadFailure());
    }
  }
}
