import 'package:hive/hive.dart';

part 'shorten_url.g.dart';

@HiveType(typeId: 0)
class ShortenUrl {
  @HiveField(0)
  late String code;
  @HiveField(1)
  late String shortLink;
  @HiveField(2)
  late String fullShortLink;
  @HiveField(3)
  late String shortLink2;
  @HiveField(4)
  late String fullShortLink2;
  @HiveField(5)
  late String shareLink;
  @HiveField(6)
  late String fullShareLink;
  @HiveField(7)
  late String originalLink;

  ShortenUrl(
      {required this.code,
      required this.shortLink,
      required this.fullShortLink,
      required this.shortLink2,
      required this.fullShortLink2,
      required this.shareLink,
      required this.fullShareLink,
      required this.originalLink});

  ShortenUrl.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortLink = json['short_link'];
    fullShortLink = json['full_short_link'];
    shortLink2 = json['short_link2'];
    fullShortLink2 = json['full_short_link2'];
    shareLink = json['share_link'];
    fullShareLink = json['full_share_link'];
    originalLink = json['original_link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['short_link'] = shortLink;
    data['full_short_link'] = fullShortLink;
    data['short_link2'] = shortLink2;
    data['full_short_link2'] = fullShortLink2;
    data['share_link'] = shareLink;
    data['full_share_link'] = fullShareLink;
    data['original_link'] = originalLink;
    return data;
  }
}
