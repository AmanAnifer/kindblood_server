// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$HomeServiceRouter(HomeService service) {
  final router = Router();
  router.add(
    'GET',
    r'/',
    service.index,
  );
  router.mount(
    r'/getContact/',
    service.getContact,
  );
  router.mount(
    r'/submitContact/',
    service.submitContact,
  );
  return router;
}
