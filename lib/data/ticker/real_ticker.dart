import 'package:der_die_das/domain/contracts/ticker.dart';

class RealTicker implements Ticker {
  // this is the actual stream that performs the calculation periodically/
  @override
  Stream tick(int startingTime) {
    return Stream.periodic(
      Duration(seconds: 1),
      (x) => startingTime - x - 1,
    ); //starts from x 0, so we want the first tick to actually be 29 and not 30 for example (what happens after one second
  }
}
