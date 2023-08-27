import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import 'package:kindblood_common/core_entities.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactInfo>>> getSearchResultContacts({
    required SearchInfo searchInfo,
    // required SortBy sortBy,
  });
  Future<Either<Failure, Success>> submitContact(
      {required MyInfo submittedContact});
}
