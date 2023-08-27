// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_contact_router.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$SubmitContactServiceImplRouter(SubmitContactServiceImpl service) {
  final router = Router();
  router.add(
    'POST',
    r'/',
    service.submitContactEndpoint,
  );
  router.add(
    'GET',
    r'/hello',
    service.hello,
  );
  return router;
}
