import 'dart:math';

String generateId(String prefix, {int length = 24}) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  final randomPart =
      List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
  return '${prefix}_$randomPart';
}
