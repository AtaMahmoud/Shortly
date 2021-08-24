/// replace [string] spaces with zero width space [\u{200B}]
extension StringOverflow on String {
  // ignore: unnecessary_this
  String get overflow => this.replaceAll("", "\u{200B}");
}
