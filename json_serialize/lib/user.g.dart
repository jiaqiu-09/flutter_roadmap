// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return User(
    json['name'] as String,
    json['email'] as String,
    (json['registration_date_millis'] as num).toInt(),
    json['isAdult'] as bool? ?? false,
    json['id'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'registration_date_millis': instance.registrationDateMillis,
      'isAdult': instance.isAdult,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
