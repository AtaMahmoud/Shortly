// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorten_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortenUrlAdapter extends TypeAdapter<ShortenUrl> {
  @override
  final int typeId = 0;

  @override
  ShortenUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortenUrl(
      code: fields[0] as String,
      shortLink: fields[1] as String,
      fullShortLink: fields[2] as String,
      shortLink2: fields[3] as String,
      fullShortLink2: fields[4] as String,
      shareLink: fields[5] as String,
      fullShareLink: fields[6] as String,
      originalLink: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShortenUrl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.shortLink)
      ..writeByte(2)
      ..write(obj.fullShortLink)
      ..writeByte(3)
      ..write(obj.shortLink2)
      ..writeByte(4)
      ..write(obj.fullShortLink2)
      ..writeByte(5)
      ..write(obj.shareLink)
      ..writeByte(6)
      ..write(obj.fullShareLink)
      ..writeByte(7)
      ..write(obj.originalLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortenUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
