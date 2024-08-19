part of 'app_env_cubit.dart';

@immutable
sealed class AppEnvState {}

final class AppEnvInitial extends AppEnvState {}

final class AppEnvLoadSuccess extends AppEnvState {
  final Map<String, String> config;
  AppEnvLoadSuccess({required this.config});
}

final class AppEnvLoadFailure extends AppEnvState {}
