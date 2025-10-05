import 'package:coffee_photos_repository/src/models/coffee_photo_data.dart';
import 'package:hive_ce/hive.dart';

/// TypeAdapter for CoffeePhotoData to enable Hive serialization
class CoffeePhotoDataAdapter extends TypeAdapter<CoffeePhotoData> {
  @override
  final int typeId = 0;

  @override
  CoffeePhotoData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoffeePhotoData(
      url: fields[0] as String,
      id: fields[1] as String,
      isFavorite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CoffeePhotoData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.isFavorite);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoffeePhotoDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
