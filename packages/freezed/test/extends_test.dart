// ignore_for_file: unused_local_variable

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';
import 'integration/extends.dart';

void main() {
  Future<LibraryElement> analyze() {
    return resolveSources(
      {
        'freezed|test/integration/extends.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere((e) {
        return e.source.fullName == '/freezed/test/integration/extends.dart';
      }),
    );
  }

  test('has no issue', () async {
    final singleClassLibrary = await analyze();

    final errorResult = await singleClassLibrary.session
            .getErrors2('/freezed/test/integration/extends.freezed.dart')
        as ErrorsResult;

    expect(errorResult.errors, isEmpty);
  });

  test(
    'when unions use the same base-class, the union still can be assigned to base, event with a different super call',
    () {
      Base base = Simple();
      Base base2 = SimpleUnion.first();
      Base base3 = SimpleUnion.second();
    },
  );

  test(
    'When not all constructors extends the same base, the union cannot be assigned to base',
    () async {
      await expectLater(compile('''
import 'extends.dart';

void main() {
  Base a;
  var base = DifferentBaseUnion.first();
}
'''), completes);

      await expectLater(compile('''
import 'extends.dart';

void main() {
  Base base = DifferentBaseUnion.first();
}
'''), throwsCompileError);
    },
  );

  test(
      'union cases can be assigned to base even when not all constructors implement the same base',
      () async {
    await expectLater(compile('''
import 'extends.dart';

void main() {
  Base base = DifferentBaseUnionFirst();
}
'''), throwsCompileError);

    await expectLater(compile('''
import 'extends.dart';

void main() {
  Base base = DifferentBaseUnionSecond();
}
'''), completes);
  });

  test('can specify super constructor', () {
    expect(SimpleUnion.first().value, null);
    expect(SimpleUnion.second().value, 42);
  });

  test('can extend Freezed classes', () {}, skip: true);

  test(
      'extending freezed class from a different file can specify a map method with different parameters',
      () {},
      skip: true);

  test(
      'can extend a freezed class specified within the same file with different constructors',
      () {},
      skip: true);

  test(
    'update toString if extending freezed class without custom toString',
    () {},
    skip: true,
  );

  test(
    'does not update toString if extending freezed class with custom toString',
    () {},
    skip: true,
  );

  test('supports fromJson/toJson', () {}, skip: true);

  test(
      'can use @ignore to mark some parameters as only used for constructor purposes',
      () {},
      skip: true);

  test(
      'when specifying a parameter using the name of an already existing property, overrides the property to use the new type',
      () {},
      skip: true);
}
