class Safe {
  Safe._();
  
  static int asInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    if (value is String) {
      return int.tryParse(value) ??
          double.tryParse(value)?.toInt() ??
          defaultValue;
    }
    return defaultValue;
  }

  static double asDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is bool) return value ? 1.0 : 0.0;
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static bool asBool(dynamic value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) return value == 0 ? false : true;
    if (value is double) return value == 0 ? false : true;
    if (value is String) {
      if (value == "1" || value.toLowerCase() == "true") return true;
      if (value == "0" || value.toLowerCase() == "false") return false;
    }
    return defaultValue;
  }

  static String asString(dynamic value, {String defaultValue = ""}) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    if (value is int) return value.toString();
    if (value is double) return value.toString();
    if (value is bool) return value ? "true" : "false";
    return defaultValue;
  }

  static Map<String, dynamic> asMap(dynamic value,
      {Map<String, dynamic>? defaultValue}) {
    if (value == null) return defaultValue ?? <String, dynamic>{};
    if (value is Map<String, dynamic>) return value;
    return defaultValue ?? <String, dynamic>{};
  }

  static List asList(dynamic value, {List? defaultValue}) {
    if (value == null) return defaultValue ?? [];
    if (value is List) return value;
    return defaultValue ?? [];
  }
}
