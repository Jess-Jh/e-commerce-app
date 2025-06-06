bool isExpressTimeActive() {
  final now = DateTime.now();
  return now.hour >= 10 && now.hour < 16;
}
