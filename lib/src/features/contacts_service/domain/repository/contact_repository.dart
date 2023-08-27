import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import 'package:kindblood_common/core_entities.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts(
      {required OnlineSearchInfo searchInfo});
  Future<Either<Failure, Success>> submitContact(
      {required MyInfo submittedContact});
}
