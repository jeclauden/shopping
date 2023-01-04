import 'dart:math';

class AppUtility {
  AppUtility._();
  final _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  final Random _rnd = Random();

  static final AppUtility _instance = AppUtility._internal();

  factory AppUtility() {
    return _instance;
  }

  AppUtility._internal();

  String _createUniqueId(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  String createProductId() {
    return _createUniqueId(10);
  }

  String createOrderId() {
    return _createUniqueId(8);
  }
}
