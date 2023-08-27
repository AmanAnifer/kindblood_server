import 'package:kindblood_server/src/features/contacts_service/presentation/submit_contact_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'src/features/contacts_service/presentation/get_contact_router.dart';
import 'src/injectable_barrel.dart';
import 'src/core/string_contacts.dart';
part 'home_service.g.dart';

class HomeService {
  @Route.get("/")
  Future<Response> index(Request request) async {
    return Response.ok("Hello there");
  }

  @Route.get("/version")
  Future<Response> version(Request request) async {
    return Response.ok(versionCode);
  }

  @Route.mount("/getContact/")
  Router get getContact => sl<GetContactService>().router;

  @Route.mount("/submitContact/")
  Router get submitContact => sl<SubmitContactService>().router;

  Handler get handler => _$HomeServiceRouter(this);
}
