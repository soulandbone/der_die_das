import 'package:der_die_das/domain/contracts/ticker.dart';

class RealTicker implements Ticker {
  @override
  Stream tick(int start) {
    return Stream.periodic(Duration(seconds: 1), (x) => start - x - 1);
  }
}
