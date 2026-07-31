
class FeatureFlagDocument {
  
  String? title;
  String description;
  AvalaiblePlatform avalaiblePlatform;
  List<OptionFlag> options;

  FeatureFlagDocument({
    this.title,
    required this.description,
    required this.avalaiblePlatform,
    required this.options,
  });

  factory FeatureFlagDocument.fromMap(Map<String, dynamic> map) =>
      FeatureFlagDocument(
        description: map['description'],
        avalaiblePlatform: AvalaiblePlatform.fromMap(map['avalaiblePlatform']),
        options: List<OptionFlag>.from(
            map['options'].map((x) => OptionFlag.fromMap(x))),
      );
}

class OptionFlag {
  AvalaiblePlatform avalaiblePlatform;
  String code;
  String description;

  OptionFlag({
    required this.avalaiblePlatform,
    required this.code,
    required this.description,
  });

  factory OptionFlag.fromMap(Map<String, dynamic> map) => OptionFlag(
        avalaiblePlatform: AvalaiblePlatform.fromMap(map['avalaiblePlatform']),
        code: map['code'],
        description: map['description'],
      );
}

class AvalaiblePlatform {
  bool android;
  bool ios;

  AvalaiblePlatform({
    required this.android,
    required this.ios,
  });

  factory AvalaiblePlatform.fromMap(Map<String, dynamic> map) =>
      AvalaiblePlatform(
        android: map['android'],
        ios: map['ios'],
      );
}
