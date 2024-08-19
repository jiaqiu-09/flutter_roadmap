import 'dart:convert';
import 'dart:io';

import 'package:json_serialize/json_serialize.dart' as json_serialize;
import 'package:json_serialize/user.dart';
import 'package:json_serialize/user_model.dart';

void main(List<String> arguments) async {
  print('Hello world: ${json_serialize.calculate()}!');
  final jsonFile = File("lib/test.json");
  // case 1
  try {
    print('case 1');
    String contents = await jsonFile.readAsString();
    final user = jsonDecode(contents) as Map<String, dynamic>;

    print('Howdy, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');
  } catch (e) {
    print(e);
  }

  // case 2
  try {
    print('case 2');
    String contents = await jsonFile.readAsString();
    final userMap = jsonDecode(contents) as Map<String, dynamic>;
    final user = UserModel.fromJson(userMap);
    print('Howdy, ${user.name}!');
    print('We sent the verification link to ${user.email}.');
    print('tojson -> ${user.toJson()}');
  } catch (e) {}

  // case 3
  try {
    print('case 3');
    String contents = await jsonFile.readAsString();
    final userMap = jsonDecode(contents) as Map<String, dynamic>;
    final user = User.fromJson(userMap);
    print('Howdy, ${user.name}!');
    print('We sent the verification link to ${user.email}.');
    print('tojson -> ${user.toJson()}');
    print('registrationDate -> ${user.registrationDate}');
  } catch (e) {}
}
