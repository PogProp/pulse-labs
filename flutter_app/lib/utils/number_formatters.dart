/// Formats large currency numbers with B (billions) and M (millions) suffixes.
///
/// Examples:
/// - 1,500,000,000 -> $1.50B
/// - 25,000,000 -> $25.00M
/// - 500,000 -> $500000
String formatLargeCurrency(double value) {
  if (value >= 1e9) {
    return '\$${(value / 1e9).toStringAsFixed(2)}B';
  } else if (value >= 1e6) {
    return '\$${(value / 1e6).toStringAsFixed(2)}M';
  } else {
    return '\$${value.toStringAsFixed(0)}';
  }
}
