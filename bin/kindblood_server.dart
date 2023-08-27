import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:kindblood_server/home_service.dart';
import 'package:kindblood_server/src/injectable_barrel.dart' as core_di;
import 'package:kindblood_server/src/core/utils/first_run_check.dart';
// Configure routes.

void main(List<String> args) async {
  await core_di.init();
  await core_di.sl<FirstRunCheck>().check();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(HomeService().handler);
  // final handler = Pipeline().addHandler(HomeService().handler);
  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8100');
  final server = await serve(handler, ip, port, poweredByHeader: null);
  print('Server listening on $ip:${server.port}');
}
