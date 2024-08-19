import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptUtil {
  static String encryptString(String plainText, String key) {
    final encryptionKey = encrypt.Key.fromBase64(key);
    final iv = encrypt.IV.fromLength(16); // 使用随机 IV
    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // 返回 IV 和密文，IV 用于解密时需要
    return '${iv.base64}:${encrypted.base64}';
  }

  static String decryptString(String encryptedText, String key) {
    final encryptionKey = encrypt.Key.fromBase64(key);

    // 从密文中分离出 IV 和密文
    final parts = encryptedText.split(':');
    if (parts.length != 2) {
      throw Exception('Invalid encrypted text format');
    }

    final iv = encrypt.IV.fromBase64(parts[0]);
    final encryptedBase64 = parts[1];

    final encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));
    try {
      final decrypted = encrypter.decrypt64(encryptedBase64, iv: iv);
      return decrypted;
    } catch (e) {
      throw Exception('Decryption failed: $e');
    }
  }

  static String generate128BitKey() {
    final keyBytes = List<int>.generate(16, (i) => Random.secure().nextInt(256));
    return base64Url.encode(keyBytes);
  }
}

void main() async {
  String key = EncryptUtil.generate128BitKey();
  print(key);

  String secretKey = 'L0Se0LEl9yPJF2vAAW-6HA==';
  String originalValue = '大法师21312';

  String encryptedValue = EncryptUtil.encryptString(originalValue, secretKey);
  print('Encrypted Value: $encryptedValue');

  String decryptedValue = EncryptUtil.decryptString(encryptedValue, secretKey);
  print('Decrypted Value: $decryptedValue');
}
