import 'package:intl/intl.dart';

class Formatters {
  static final currencyFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final percentFormatter = NumberFormat('+#,##0.00;-#,##0.00');
}
