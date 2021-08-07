import 'package:freezed_annotation/freezed_annotation.dart';

part 'extends.freezed.dart';
part 'extends.g.dart';

abstract class Base {
  Base({this.value});

  Base.double(int value) : value = value * 2;

  final Object? value;

  Object? get getter => 42;

  Object? get abstractProperty;

  int function(int a, {required int b, String? c}) {
    return 42;
  }

  int abstractFunction(int a, {required int b, String? c});
}

mixin BaseImpl on Base {
  @override
  Object? get abstractProperty => 'abstractProperty';

  @override
  int abstractFunction(int a, {required int b, String? c}) {
    return 0;
  }
}

@freezed
abstract class Simple with _$Simple {
  @Extends<Base>('super()')
  @With<BaseImpl>()
  factory Simple() = _Simple;
}

@freezed
abstract class SimpleUnion with _$SimpleUnion {
  @Extends<Base>('super()')
  @With<BaseImpl>()
  factory SimpleUnion.first() = _SimpleUnionFirst;

  @Extends<Base>('super(value: 42)')
  @With<BaseImpl>()
  factory SimpleUnion.second() = _SimpleUnionSecond;
}

@freezed
abstract class DifferentBaseUnion with _$DifferentBaseUnion {
  factory DifferentBaseUnion.first() = DifferentBaseUnionFirst;

  @Extends<Base>('super()')
  @With<BaseImpl>()
  factory DifferentBaseUnion.second() = DifferentBaseUnionSecond;
}

abstract class SerializableBase {
  SerializableBase(this.value);

  SerializableBase.fromJson(Map<String, Object?> json)
      : this(json['value']! as String);

  final String value;

  Map<String, Object?> toJson() => {'value': value};
}

@freezed
abstract class SerializableUnion with _$SerializableUnion {
  factory SerializableUnion.first() = SerializableUnionFirst;

  @Extends<SerializableBase>('super()')
  factory SerializableUnion.second() = SerializableUnionSecond;

  factory SerializableUnion.fromJson(Map<String, Object?> json) =>
      _$SerializableUnionFromJson(json);
}

@freezed
class FreezedSerializableBase {
  factory FreezedSerializableBase(String value) = _FreezedSerializable;

  factory FreezedSerializableBase.fromJson(Map<String, Object?> json) =>
      _$FreezedSerializableBaseFromJson(json);
}

@freezed
abstract class FreezedSerializableUnion with _$FreezedSerializableUnion {
  factory FreezedSerializableUnion.first() = FreezedSerializableUnionFirst;

  @Extends<FreezedSerializableBase>('super()')
  factory FreezedSerializableUnion.second() = FreezedSerializableUnionSecond;

  factory FreezedSerializableUnion.fromJson(Map<String, Object?> json) =>
      _$FreezedSerializableUnionFromJson(json);
}
