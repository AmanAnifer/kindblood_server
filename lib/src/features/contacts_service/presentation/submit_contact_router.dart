import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../domain/usecase/submit_contact.dart';
part 'submit_contact_router.g.dart';

abstract class SubmitContactService {
  Router get router;
}

class SubmitContactServiceImpl implements SubmitContactService {
  final SubmitContactUseCase submitContactUseCase;
  SubmitContactServiceImpl({required this.submitContactUseCase});

  @Route.post("/")
  Future<Response> submitContactEndpoint(Request request) async {
    var got = await request.readAsString();
    var result = await submitContactUseCase.submitContact(
        submittedContactJsonString: got);
    return result.fold(
      (l) => Response.badRequest(),
      (r) => Response.ok(null),
    );
  }

  @Route.get("/hello")
  Future<Response> hello(Request request) async {
    return Response.ok("Hi!!!");
  }

  @override
  Router get router => _$SubmitContactServiceImplRouter(this);
}
