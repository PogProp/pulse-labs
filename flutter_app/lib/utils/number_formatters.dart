/// Formats large currency numbers with B (billions), M (millions), and K (thousands) suffixes.
///
/// Examples:
/// - 1,500,000,000 -> $1.50B
/// - 25,000,000 -> $25.00M
/// - 45,000 -> $45K
/// - 500 -> $500
String formatLargeCurrency(double value) {
  if (value >= 1e9) {
    return '\$${(value / 1e9).toStringAsFixed(2)}B';
  } else if (value >= 1e6) {
    return '\$${(value / 1e6).toStringAsFixed(2)}M';
  } else if (value >= 1e3) {
    return '\$${(value / 1e3).toStringAsFixed(0)}K';
  } else {
    return '\$${value.toStringAsFixed(0)}';
  }
}
