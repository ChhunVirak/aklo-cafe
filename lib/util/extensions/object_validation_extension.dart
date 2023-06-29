extension StringValidate on String? {
  bool get isValid => this != null && this?.isNotEmpty == true;
}

extension ListValidate on List? {
  bool get isValid => this != null && this?.isNotEmpty == true;
}

extension IterableValidate on Iterable? {
  bool get isValid => this != null && this?.isNotEmpty == true;
}

extension MapValidate on Map? {
  bool get isValid => this != null && this?.isNotEmpty == true;
}

extension ObjectValidate on Object? {
  bool get isNuull => this == null;
  bool get notNull => this != null;
}
