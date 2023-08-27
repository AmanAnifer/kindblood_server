import 'package:fpdart/fpdart.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_common/utils.dart';
import '../repository/contact_repository.dart';

class GetContactUseCase {
  final ContactRepository contactRepository;
  GetContactUseCase({required this.contactRepository});

  Future<Either<Failure, List<ContactInfoWithSearchInfoContext>>>
      getSearchResultContacts({
    required Map<String, dynamic> searchInfoMap,
    required Map<String, dynamic> sortByMap,
  }) async {
    final SearchInfo searchInfo = SearchInfo.fromJson(searchInfoMap);
    final SortBy sortBy = SortBy.fromJson(sortByMap);
    var result = await contactRepository.getSearchResultContacts(
      searchInfo: searchInfo,
      // sortBy: sortBy,
    );
    var contactComparator = ContactComparator(sortBy: sortBy);
    return result.fold(
      (l) => Either.left(l),
      (r) {
        return Either.right(
          r
              .map(
                (e) => getContactInfoWithContext(
                  contact: e,
                  searchInfo: searchInfo,
                ),
              )
              .toList()
            ..sort(contactComparator.comparator),
        );
        // .sort();
      },
    );
  }
}
