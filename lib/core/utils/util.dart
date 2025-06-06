extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? this[0].toUpperCase() + substring(1).toLowerCase() : this;

  String toTitleCase() =>
      split(' ').map((word) => word.toCapitalized()).join(' ');
}
