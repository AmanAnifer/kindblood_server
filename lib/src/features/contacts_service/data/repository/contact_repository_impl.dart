import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/entities/contact_info.dart';
import 'package:kindblood_server/src/core/entities/myinfo_entity.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import 'package:kindblood_server/src/features/contacts_service/domain/entities/search_info.dart';
import '../../domain/repository/contact_repository.dart';
import '../datasource/contact_datastore.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDataStore contactDataStore;
  ContactRepositoryImpl({required this.contactDataStore});

  @override
  Future<Either<Failure, List<OnlineContactInfo>>> getSearchResultContacts({
    required OnlineSearchInfo searchInfo,
  }) async {
    return (await contactDataStore.getSearchResultContacts(
            searchInfo: searchInfo))
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
