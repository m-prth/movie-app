extension NumExtension on num? {
  String convertToPercentage() {
    return ((this ?? 0) * 10).toStringAsFixed(0) + ' %';
  }
}
