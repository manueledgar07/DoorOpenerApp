import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cryption.dart';

// Manage SecretKey, Nonce and Password
class KeyManager {
  final _storage = FlutterSecureStorage();
  static const cipher = aesGcm;

  // Init the Password Hashing, Nonce Generation and SecretKey Generation
  // Store them in SecuredStorage
  Future<bool> firstStart(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool first = prefs.getBool('first') ?? true;
    if (first) {
      final secretKey = cipher.newSecretKeySync(length: 16);
      final Uint8List uint8Key = secretKey.extractSync();
      final hexKey = hex.encode(uint8Key);
      await _storage.write(key: 'hexKey', value: hexKey);
      final hashPassword = await Cryption().passwordHash(password, null);
      await _storage.write(key: 'hashedPassword', value: hex.encode(hashPassword));
      prefs.setBool('first', false);
      return true;
    }
    return true;
  }

  void reset() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first', true);
    _storage.deleteAll();
  }

  // Return an Object of Type SecretKey
  Future<SecretKey> getSecretKey() async {
    return new SecretKey(hex.decode(await _storage.read(key: 'hexKey')));
  }

  // Return an String with the HexKey
  Future<String> getHexKey() async {
    return await _storage.read(key: 'hexKey');
  }

  // Safe an Hex Converted Key
  Future<void> safeHexKey(String hexKey) async {
    await _storage.write(key: 'hexKey', value: hexKey);
  }

  // Safe an Hex Converted Password Nonce
  Future<void> safePasswordHexNonce(String hexNonce) async {
    await _storage.write(key: 'hexNonce', value: hexNonce);
  }

  // Safe an Hex Password
  Future<void> safeHexPassword(String hexPassword) async{
    await _storage.write(key: 'hashedPassword', value: hexPassword);
  }

  // Return an String with the HashedPassword
  Future<String> getHexPassword() async {
    return await _storage.read(key: 'hashedPassword');
  }

  void changePassword(String newHashPassword) async{
    await _storage.write(key: 'hashedPassword', value: newHashPassword);
  }

  void safePasswordNonce(Nonce nonce) async{
    await _storage.write(key: 'hexNonce', value: hex.encode(nonce.bytes));
  }

  Future<Nonce> getPasswordNonce() async{
    return Nonce(hex.decode(await _storage.read(key: 'hexNonce')));
  }

}
