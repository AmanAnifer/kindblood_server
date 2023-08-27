import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../domain/usecase/get_contact.dart';
part 'get_contact_router.g.dart';

abstract class GetContactService {
  Router get router;
}

class GetContactServiceImpl implements GetContactService {
  final GetContactUseCase getContactUseCase;
  GetContactServiceImpl({required this.getContactUseCase});

  @Route.post("/")
  Future<Response> getContactEndpoint(Request request) async {
    var got = await request.readAsString();
    var contactsList = await getContactUseCase.getSearchResultContacts(
        searchInfoJsonString: got);
    return contactsList.fold(
      (l) => Response.badRequest(),
      (r) => Response.ok(
        jsonEncode(r),
      ),
    );
  }

  @Route.get("/hi")
  Future<Response> hello(Request request) async {
    return Response.ok("Hi!!!");
  }

  @override
  Router get router => _$GetContactServiceImplRouter(this);
}
