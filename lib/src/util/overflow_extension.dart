/// https://github.com/flutter/flutter/issues/18761
extension OverFlow on String {
  // ignore: unnecessary_this
  String get overflow => this.replaceAll("", "\u{200B}");
}
