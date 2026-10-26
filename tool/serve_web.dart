// Serves the release web build with single-page fallback: a path that isn't a
// file gets index.html, so a deep link or a refresh on /orders/<id> loads the
// app instead of a 404 from the server. The same job as `npx serve -s`, with
// nothing to install beyond Flutter.
//
//   cd apps/checkout_app && flutter build web --release
//   dart run tool/serve_web.dart [port]        (from the repo root)

import 'dart:io';

const Map<String, String> _contentTypes = <String, String>{
  'html': 'text/html; charset=utf-8',
  'js': 'text/javascript',
  'mjs': 'text/javascript',
  'json': 'application/json',
  'wasm': 'application/wasm',
  'css': 'text/css',
  'png': 'image/png',
  'ico': 'image/x-icon',
  'svg': 'image/svg+xml',
  'ttf': 'font/ttf',
  'otf': 'font/otf',
};

Future<void> main(List<String> args) async {
  final int port = args.isEmpty ? 8080 : int.parse(args.first);
  final Directory root = Directory.fromUri(
    Platform.script.resolve('../apps/checkout_app/build/web/'),
  );
  final File index = File.fromUri(root.uri.resolve('index.html'));
  if (!index.existsSync()) {
    stderr.writeln(
      'No web build found. Run `flutter build web --release` in '
      'apps/checkout_app first.',
    );
    exitCode = 1;
    return;
  }

  final HttpServer server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    port,
  );
  stdout.writeln('Serving the web build at http://localhost:$port');

  await for (final HttpRequest request in server) {
    final List<String> segments = request.uri.pathSegments;
    File file = File.fromUri(root.uri.resolve(segments.join('/')));
    if (segments.isEmpty || segments.contains('..') || !file.existsSync()) {
      file = index;
    }
    final String extension = file.path.split('.').last;
    request.response.headers.set(
      HttpHeaders.contentTypeHeader,
      _contentTypes[extension] ?? 'application/octet-stream',
    );
    await request.response.addStream(file.openRead());
    await request.response.close();
  }
}
