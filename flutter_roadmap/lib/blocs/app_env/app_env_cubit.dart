import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:scripts/encrypt.dart';

part 'app_env_state.dart';

class AppEnvCubit extends Cubit<AppEnvState> {
  AppEnvCubit() : super(AppEnvInitial());

  loadConfig() async {
    try {
      await dotenv.load(fileName: '.env');
      final secretKey = dotenv.env['SECRET_KEY']!;
      final url = EncryptUtil.decryptString(dotenv.env['GIT_URL']!, secretKey);
      final token = EncryptUtil.decryptString(dotenv.env['GIT_TOKEN']!, secretKey);
      emit(
        AppEnvLoadSuccess(
          config: dotenv.env,
          gitConfig: GitConfig(
            url: url,
            token: token,
          ),
        ),
      );
    } catch (_) {
      emit(AppEnvLoadFailure());
    }
  }
}
