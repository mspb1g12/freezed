import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';

/// Renders a type based on its string + potential import alias
String resolveFullTypeStringFrom(
  LibraryElement originLibrary,
  DartType type, {
  required bool withNullability,
}) {
  final owner = originLibrary.prefixes.firstWhereOrNull(
    (e) => type.element!.isAccessibleIn(e.enclosingElement),
  );

  if (owner != null) {
    return '${owner.name}.${type.getDisplayString(withNullability: withNullability)}';
  }

  return type.getDisplayString(withNullability: withNullability);
}

/// Builder for "extends Foo with Bar implements Baz", supporting separators
/// and optionality.
String buildInheritance({
  String? baseClass,
  List<String>? mixins,
  List<String>? interfaces,
}) {
  final builder = StringBuffer();

  if (baseClass != null) {
    builder
      ..write('extends ')
      ..write(baseClass)
      ..write(' ');
  }

  if (mixins != null && mixins.isNotEmpty) {
    builder
      ..write('with ')
      ..writeAll(mixins, ',')
      ..write(' ');
  }
  if (interfaces != null && interfaces.isNotEmpty) {
    builder
      ..write('implements ')
      ..writeAll(interfaces, ',')
      ..write(' ');
  }

  return builder.toString();
}
