// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_contact_router.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$GetContactServiceImplRouter(GetContactServiceImpl service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.getContactEndpoint,
  );
  router.add(
    'GET',
    r'/hi',
    service.hello,
  );
  return router;
}
