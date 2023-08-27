import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../domain/usecase/get_contact.dart';
import 'package:kindblood_common/constants.dart';
part 'get_contact_router.g.dart';

abstract class GetContactService {
  Router get router;
}

class GetContactServiceImpl implements GetContactService {
  final GetContactUseCase getContactUseCase;
  GetContactServiceImpl({required this.getContactUseCase});

  @Route.post("/")
  Future<Response> getContactEndpoint(Request request) async {
    var gotMap = jsonDecode(await request.readAsString());
    var gotSearchInfoMap =
        gotMap[JsonKeys.searchInfoJsonKey] as Map<String, dynamic>;
    var gotSortByMap = gotMap[JsonKeys.sortByJsonKey] as Map<String, dynamic>;
    var contactsList = await getContactUseCase.getSearchResultContacts(
      searchInfoMap: gotSearchInfoMap,
      sortByMap: gotSortByMap,
    );
    return contactsList.fold(
      (l) => Response.badRequest(),
      (r) => Response.ok(
        headers: {"Content-Type": "application/json"},
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
