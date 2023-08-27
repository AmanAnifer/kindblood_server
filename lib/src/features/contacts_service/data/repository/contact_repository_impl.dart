import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import '../../domain/repository/contact_repository.dart';
import '../datasource/contact_datastore.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataStore contactDataStore;
  ContactRepositoryImpl({required this.contactDataStore});

  @override
  Future<Either<Failure, List<ContactInfo>>> getSearchResultContacts({
    required SearchInfo searchInfo,
    // required SortBy sortBy,
  }) async {
    return (await contactDataStore.getSearchResultContacts(
      searchInfo: searchInfo,
      // sortBy: sortBy,
    ))
        .fold(
      (l) => Either.left(DatabaseFailure()),
      (r) => Either.right(r),
    );
  }

  @override
  Future<Either<Failure, Success>> submitContact({
    required MyInfo submittedContact,
  }) async {
    return (await contactDataStore.submitContact(
      submittedContact: submittedContact,
    ))
        .fold(
      (l) => Either.left(DatabaseFailure()),
      (r) => Either.right(r),
    );
  }
}
