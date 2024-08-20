part of 'app_env_cubit.dart';

@immutable
sealed class AppEnvState {}

final class AppEnvInitial extends AppEnvState {}

final class GitConfig {
  final String url;
  final String token;
  const GitConfig({required this.url, required this.token});
}

final class AppEnvLoadSuccess extends AppEnvState {
  final Map<String, String> config;
  final GitConfig gitConfig;
  AppEnvLoadSuccess({required this.config, required this.gitConfig});
}

final class AppEnvLoadFailure extends AppEnvState {}
