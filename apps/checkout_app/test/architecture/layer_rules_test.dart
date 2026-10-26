import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Fails the build when a layer imports something it shouldn't, so the rules
// can't quietly rot now that the feature lives inside the app package. The
// pure Dart packages (graphql_api, local_backend) don't need it: their pubspecs
// don't depend on Flutter, so the import wouldn't resolve.
void main() {
  void expectNoImports(
    String directory,
    List<String> forbidden,
    String reason,
  ) {
    final List<File> files = Directory(directory)
        .listSync(recursive: true)
        .whereType<File>()
        .where((File file) => file.path.endsWith('.dart'))
        .toList();
    expect(files, isNotEmpty, reason: 'No Dart files under $directory');

    for (final File file in files) {
      final Iterable<String> offending = file
          .readAsLinesSync()
          .where((String line) => line.trimLeft().startsWith('import '))
          .where(
            (String line) => forbidden.any((String bad) => line.contains(bad)),
          );
      expect(offending, isEmpty, reason: '${file.path}: $reason');
    }
  }

  test('core is pure Dart and depends on no layer', () {
    expectNoImports('lib/core', <String>[
      'package:flutter/',
      'package:ferry/',
      'package:graphql_api/',
      '/domain/',
      '/data/',
      '/presentation/',
    ], 'core is shared by every layer, so it can depend on none of them');
  });

  test('domain imports nothing from data, presentation, Flutter or GraphQL', () {
    expectNoImports(
      'lib/features/checkout/domain',
      <String>[
        'package:flutter/',
        'package:ferry/',
        'package:graphql_api/',
        '/data/',
        '/presentation/',
      ],
      'dependencies point inward: data implements the domain, never the reverse',
    );
  });

  test('data never imports presentation or Flutter', () {
    expectNoImports('lib/features/checkout/data', <String>[
      'package:flutter/',
      '/presentation/',
    ], 'the data layer must not know how anything is shown');
  });

  test('presentation never imports GraphQL or the data layer', () {
    expectNoImports('lib/features/checkout/presentation', <String>[
      'package:ferry/',
      'package:graphql_api/',
      '/data/',
    ], 'views and view models only see domain types and repository interfaces');
  });
}
